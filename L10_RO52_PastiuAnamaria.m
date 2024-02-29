uz=zeros(20,1);
u_step=0.3*ones(70,1);
Ts=0.01;
uval=[uz; u_step; uz];


uid=idinput(200,'prbs',[],[-0.8 0.8]);
% [vel,alpha,t]=run(U,'10');


motor= DCMRun.start("Ts", 10e-3);
for k = 1:length(uval)
        motor.wait;
    yval(k)= motor.step(uval(k));
end


%save
na=7;
nb=7;
theta=zeros((na+nb),1);
P=[];
for i=1:(na+nb)
    for j=1:(na+nb)
     if i==j
         P(i,j)=1000;
     else 
         P(i,j)=0;
     end
    end
end
%W=zeros(na+nb,length(uid));

for k= 1:length(uid)
        motor.wait;
    yid(k)= motor.step(uid(k));
    
phi=[];
for i=1:na
    if (k-i)<=0
        phi(i)=0;
    else 
        phi(i)=-yid(k-i);
    end
end
for j=1:nb
    if (k-j)<=0
        phi(j+na)=0;
    else
        phi(j+na)=uid(k-j);
    end
end

e=yid(k)-phi*theta;
P=P-(P*(phi')*phi*P)/(1+phi*P*phi');
W=P*phi';
theta=theta+W*e;


motor.wait;
end
motor.stop();
A=[];
 A(1)=1;
   
for i=2:na+1
    A(i)=theta(i-1);
end

B(1)=0;
for i=2:nb+1
    B(i)=theta(i+na-1);
end
model1=idpoly(A,B,[],[],[],0,Ts);
val=iddata(yval',uval,Ts);
compare(model1,val);
