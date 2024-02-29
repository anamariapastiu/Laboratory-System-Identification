load("lab5_4.mat")
u_identificare=id.InputData;
y_identificare=id.OutputData;
u_validare=val.InputData;
y_validare=val.OutputData;
figure
plot(tid,u_identificare)
title('intrare')
figure
plot(tid,y_identificare)
title('iesire')

figure
plot(tval,u_validare)
hold on
plot(tval,y_validare)
%%
load("lab5_4.mat")
u_identificare=id.InputData;
y_identificare=id.OutputData;
u_validare=val.InputData;
y_validare=val.OutputData;

U=detrend(u_identificare )
Y=detrend(y_identificare)
figure
plot(U)
figure
plot(Y)

N=length(U);

ru = [];
for tau=0:N-1
    r=0;
    for k=1:N-tau
        r=r+(U(k+tau)*U(k));
    end
    ru(tau+1)=(1/N)*r;
end


ryu = [];
for tau=0:N-1
    ry=0;
    for k=1:N-tau
    ry=ry+(Y(k+tau))*U(k);
    end
    ryu(tau+1)=(1/N)*ry;
    
end


Ryu=ryu;

M=50;
RU=[];
for i=1:N
    for j=1:M-1
    if (i==j)
        RU(i,j)=ru(1);
    end
    if i<j
        RU(i,j)=ru(j+1-i);
    end
    if (i>j)
        RU(i,j)=ru(i+1-j);
    end
    end
end

H=RU\Ryu';
figure 
 plot(imp)
 hold on
plot(H);
yhat=conv(H,U);
Yhat_identificare=yhat(1:length(U));
yhat_val=conv(H,u_validare);
Yhat_validare=yhat_val(1:length(u_validare));

figure
plot(Y)
hold on
plot(yhat)

figure
plot(y_validare)
hold on 
plot(yhat_val)

N_val=length(u_validare);
e_id=Y-Yhat_identificare;
e_validare=y_validare-Yhat_validare;
MSE_id=(1/N)*sum(e_id.^2)
MSE_val=(1/N_val)*sum(e_validare.^2)