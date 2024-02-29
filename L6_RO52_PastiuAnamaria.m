%citire de pe motor
% uz=zeros(10,1);
% N=200;
% u_spab=idinput(N, 'prbs', [], [-0.7,0.7]);
% u_step=0.4*ones(70,1);
% u=[uz; u_spab; uz; u_step] %u_spab=u_id  u_step=u_val
% Ts=0.01;
% plot(u)

load('lab6_2.mat')
u1=id.InputData;
y1=id.OutputData;
u2=val.InputData;
y2=val.OutputData;

figure 
plot(u1)
figure
subplot(212)
plot(y1)
subplot(221)
plot(u2)
subplot(222)
plot(y2)
%%
N=length(u1);
na=10;
nb=10;
M=na+nb;
phi_1=[];

for i=1:N
    for j=1:na
%     if (i==j)
%         phi_1(i,j)=-y1(1);
%     end

    if (i>j)
        phi_1(i,j)=-y1(i-j);
    end
    if (i-j)<=1
        phi_1(i,j)=0;
    end
  
end
end

phi_2=[];

for i=1:N
    for j=1:nb
%     if (i==j)
%         phi_2(i,j)=u1(1);
%     end
    if (i-j)<=0
        phi_2(i,j)=0;
    end
    if (i>j)
        phi_2(i,j)=u1(i-j);
    end
end
end
PHI=cat(2,phi_1,phi_2);

N1=length(u2);
phi1_val=[];

for i=1:N1
    for j=1:na
    if (i>j)
        phi1_val(i,j)=-y2(i-j);
    end
    if (i-j)<=1
        phi1_val(i,j)=0;
    end
  
end
end

phi2_val=[];

for i=1:N1
    for j=1:nb
    if (i-j)<=0
        phi2_val(i,j)=0;
    end
    if (i>j)
        phi2_val(i,j)=u2(i+1-j);
    end
end
end

PHI_val=cat(2,phi1_val,phi2_val);
theta=PHI\y1;
ypred_id=PHI*theta;
ypred_val=PHI_val*theta;

e=y2-ypred_val;
mse_val1=(1/length(u2))*sum(e.^2)

figure
plot(ypred_id)
hold on
plot(y1)


figure
plot(ypred_val)
hold on
plot(y2)

yvali=zeros(1, length(u2));
phival=[];
phi2val=[];

for i=1:length(u2)
    
   for j=1:na
%     if (i-j)<=0
%      phival(i,j)=0;
%     end
     if (i-j)>0
      %  phival(i,j)=-yvali(i-j);
    
    yvali(i)=yvali(i) - yvali(i-j)*theta(j);
     end
   end

   for j=1:nb
%     if (i-j)<=0
%         phi2val(i,j)=0;
%     end
    if (i-j)>0
        %phi2val(i,j)=u2(i-j);
    
    yvali(i)=yvali(i)+u2(i-j)*theta(j+na);
   end
   end
end

e_2sim=y2-yvali;
mse_valsim=(1/length(u2))*sum(e_2sim.^2);

s=0;
for i=1:length(y2)
    s=s+(y2(i)-yvali(i)).^2;

end
MSE_valisim=(1/length(y2))*s


figure
plot(yvali)
hold on
plot(y2,'r')

