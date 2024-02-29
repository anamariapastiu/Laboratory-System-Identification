clear all
clc
close all
load('date_lab9.mat')


figure
plot(u)
figure
plot(vel)
%%
u_id=u(1:360);
y_id=vel(1:360);

u_val=u(361:650);
y_val=vel(361:650);

na=4;
nb=4;
nk=1;
Ts=0.01;


identificare=iddata(y_id',u_id,Ts);
modelarx=arx(identificare,[na,nb,nk]);
yhat=compare(modelarx,identificare);
y_hat=yhat.OutputData;
compare(modelarx,identificare);

N=length(u_id)
z=[];


%matricea de var. instrumentale
for k=1:N
    for i=1:na
        if (k-i)<=0
            z(k,i)=0;
        else
        z(k,i)=-y_hat(k-i);
        end
        
    end
    for j=1:nb
        if (k-j)<=0
            z(k,j+na)=0;
        else
            z(k,j+na)=u_id(k-j);
        end
    end
end

%matricea de regresori
phi=[];
for k=1:N
  for i=1:na
    if (k-i)<=0
        phi(k,i)=0;
    else
        phi(k,i)=-y_id(k-i);
    end

  end

  for j=1:nb

    if (k-j)<=0
        phi(k,na+j)=0;
    else
        phi(k,na+j)=u_id(k-j);
    end
  end
end

%     s1=0;
% p=[];
% for k=1:N
%     p=z'*phi;
%     s1=s1+p;
% end

PHI=1/N*(z'*phi);
Y=sum(z.*y_id')/N;

theta=PHI\Y';

A(1)=1;
for i=2:na+1
    A(i)=theta(i-1);
end

for i=1:nb+1
    if i<=nk
        B(i)=0;
    else
        B(i)=theta(na+i-1);
    end
end

model=idpoly(A,B,1,1,1,0,Ts);

val=iddata(y_val',u_val,Ts);
compare(model,val)
