load('lab4_order1_2.mat')
u_1=data.InputData;
y_1=data.OutputData;
figure
plot(t,u_1)
hold on
plot(t,y_1)

y1max=3.95
a=y_1(1):y_1(30)
yss=mean(a)
uss=u_1(1)
K=yss/uss
yt2=0.368*(y1max-yss)+yss
t2=5.70;
t1=3.72;
T=t2-t1;
H1=tf(K,[T,1])
A=(-1/T)
B=K/T
C=1
D=0
H=ss(A,B,C,D)
figure
lsim(H,u_1(131:330),t(131:330),yss)
hold on
plot(t,y_1,'r')

y_val=lsim(H,u_1,t)
e=y_1-y_val;
MSE=1/length(y_val)*sum(e.^2)


%%
load('lab4_order2_2.mat')
u_2=data.InputData;
y_2=data.OutputData;
plot(t,u_2)
hold on
plot(t,y_2)
figure
plot(t,y_2)

%tp=1:30;
yss_2=mean(y_2(101:130))
uss_2=1;
K2=yss_2/uss_2
t1=3.11;
t3=5.33;
Ts=t(5)-t(4)
T0=t3-t1;
k0=31 %indicele esantionului corespunzator lui t01
k1=42 %indicele esantionului corespunzator lui t02
k2=54 %indicele esantionului corespunzator lui t03
s1=0;
for k=k0:k1
    s1=s1+(y_2(k)-yss_2)

end
%s1=sum(y_2(k0:k1)-yss_2)
Aplus=Ts*s1;

s2=0;
for k=k1:k2
   s2=s2+(yss_2-y_2(k))
end
%s2=sum(yss_2-y_2(k1:k2))
Aminus=abs(Ts*s2);
M=Aminus/Aplus;
zeta=log(1/M)/sqrt(pi^2+log(M).^2)
wn=(2*pi)/(T0*sqrt(1-zeta^2))
A=[0 1; -wn^2 -2*zeta*wn];
B=[0; K2*wn^2]
C=[1 0]
D=[0]
sys=ss(A,B,C,D)

figure
lsim(sys,u_2(131:330),t(131:330),[yss_2 0],'r')
hold on
plot(t,y_2)

y_2_val=lsim(sys,u_2,t);
e2=y_2-y_2_val;
MSE2=1/length(y_2_val)*sum(e2.^2)


