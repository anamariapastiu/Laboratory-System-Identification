load('lab3_order1_3.mat')
u1=data.InputData;
y1=data.OutputData
plot(t,u1)
hold on
plot(t,y1)
title('ordinul 1')
%load('lab3_order2_3.mat')
%u2=data.InputData;
%y2=data.OutputData;
%figure
%plot(data)
%figure
%plot(t,u2)
%hold on
%plot(t,y2)
%title('ordinul 2')

A=t(70):t(100)
 tst=mean(A)
 for i=1:100
   if t(i)==tst
       break
   end
 end
 poz =i;
yss=y1(poz);
y01=y1(1);
uss=u1(1);
u01=u1(101)
k=(yss-y01)/(uss-u01);
t0=t(1);
yt1=0.632*(yss-y01)+y01;
t1=2.94;
T=t1-t0;
H=tf(k,[T 1])
figure
lsim(H,u1,t)
title('sistem i')
y_val=lsim(H,u1(201:500),t(201:500))
u=u1(201:500)
t1=t(201:500)
lsim(H,u,t1)
hold on
plot(t1,y1(201:500))

e=y1(201:500)-y_val
MSE=1/length(y_val)*sum(e.^2)



%%
load('lab3_order2_3.mat')
u2=data.InputData;
y2=data.OutputData;
%figure
%plot(data)
figure
plot(t,u2)
hold on
plot(t,y2)
title('ordinul 2')

uss2=u2(1)
u02=u2(101)
y02=y2(1)
B=20:35
tss2=mean(B)
for i=1:100
   if t(i)==tss2
       break
   end
end
p=i;
yss2=y2(p)
ymax=9;
K=(yss2-y02)/(uss2-u02)
M=(ymax-yss2)/(yss2-y02)
zeta=log(1/M)/sqrt(pi^2+log(M).^2)
t2=10.15;
t1=3.5;
T0=t2-t1
wn=2*pi/T0*sqrt(1-zeta.^2)
    H2=tf(K*wn.^2,[1 2*zeta*wn wn.^2])
 figure
 lsim(H2,u2,t)
 u_val=u2(201:500)
t_val=t(201:500)
b=lsim(H2,u_val,t_val)
hold on
plot(t_val,y2(201:500),'r')

e2=y2(201:500)-b;
MSE2=1/length(b)*sum(e2.^2)
