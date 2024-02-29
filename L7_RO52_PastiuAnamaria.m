load('data.mat')

u3=spab(200,3,-0.7,0.7);
u10=spab(200,10,-0.7,0.7);

us=0.4*ustep(70);

U=[zeros(1,10) u3 zeros(1, 10) u10 us' ]
%[vel, alpha, t] = run(U, '4', 10e-3);


y1=vel(11:210);
y2=vel(221:420);
yval=vel(431:510);
plot(t,vel)

Ts=0.001;
na=32;
nb=32;
na2=68;
nb2=68;
 nk=1;
% nn=struc(na,nb,nk);
% nn2=struc(na2,nb2,nk);
% v=arxstruc(identificare1,validare,nn);
% v2=arxstruc(identificare2,validare,nn2);
% N=selstruc(v,0);
% N2=selstruc(v2,0);

identificare1=iddata(y1',u3',Ts);
mod3_identificare1=arx(identificare1, [na,na,nk]);
identificare2=iddata(y2',u10',Ts);
mod10_identificare2=arx(identificare2, [na2,nb2,nk])
validare=iddata(yval',us,Ts);
mod_validare=arx(validare, [3,3,1]);
figure
compare(mod3_identificare1,validare);
figure
compare(mod10_identificare2,validare);
figure
compare(mod_validare,validare);




function [u_prim]=spab(N,m,c, b)
if m==3
    aindice=[1 0 1];
elseif m==4
    aindice=[1 0 0 1];
elseif m==5
    aindice=[0 1 0 0 1];
elseif m==6
    aindice=[1 0 0 0 0 1];
elseif m==7
    aindice=[1 0 0 0 0 0 1];
elseif m==8
    aindice=[1 1 0 0 0 1 1];
elseif m==9
    aindice=[0 0 0 1 0 0 0 0 1];
elseif m==10
    aindice=[0 0 1 0 0 0 0 0 0 1];
end
A=[];
for i=1:m
    for j=1:m
        if i==1
     A(i,j)=aindice(j);
        elseif i-j==1
            A(i,j)=1;
        else
            A(i,j)=0;
    end
    end
end
    for i=1:m
if i==m
    C(i)=1;
else
    C(i)=0;
end
    end
x=ones(m,1);

 for k=1:N
u=C*x;
x=mod((A*x),2);

u_prim(k)=c+(b-c)*u;
 end
    end
