
load('motor8.mat')
figure
plot(U)
figure
plot(vel)
%%
u_id=U(11:220);
figure
plot(u_id)
y_id=vel(11:220);
figure
plot(y_id)
Ts=10e-3;

u_val=U(218:300);
y_val=vel(218:300);
val=iddata(y_val',u_val',Ts);
plot(val);
%%
alpha =0.1;
prag=1e-3;
lmax=3000;
nk=3;
l=1;
theta=[1; 2];
e=zeros(1,length(u_id));
delta=zeros(2,length(u_id));

for l=1:lmax

f=theta(1,l);
b=theta(2,l);
hessian=zeros(nk);
dv=[0;0];

for k=1:nk
  e(k)=y_id(k);
  delta(:,k)=[0 0];
end

for j=(nk+1):length(u_id)
e(j)=y_id(j)-f*y_id(j-1)-b*u_id(j-nk)-f*e(j-1);
delta(1,j)=y_id(j-1)-e(j-1)-f*delta(1,j-1);
delta(2,j)=-u_id(j-nk)-f*delta(2,j-1);
end


N=length(u_id);
   s1=0;
    
        for j=1:N
        s1=s1+delta(:,j)*e(j);
        
        end
        deltaV=(2/(N-nk))*s1;
    


   s2=0;
    
        for j=1:N
        s2=s2+delta(:,j)*(delta(:,j))';
        
        end
        hessian=(2/(N-nk))*s2;
    
H=inv(hessian);
prod=H*deltaV;
theta(:,l+1)=theta(:,l)-alpha*prod;


if norm(theta(:,l+1)-theta(:,l))<=prag
       break;
end
end

A=1;
C=1;
D=1;
z=zeros(1,nk);
B=[z, b];
F=[1,f];
model=idpoly(A,B,C,D,F,0,Ts);

compare(model,val)
