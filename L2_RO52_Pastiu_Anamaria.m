load('lab2_11.mat')
%1
plot(id.X,id.Y)
hold on
plot(val.X,val.Y)
title('Date de intrare')
%2
 %numarul de esantioane
 mse_vector=[];

 for n=1:25
     
x=id.X;
y=id.Y;
x2=val.X;
y2=val.Y;
N1=length(x);
PHI_id=[];
for k=1:N1
 for i=1:n
   PHI_id(k,i)=x(k).^(i-1);
 end
end
PHI_val=[];
N2=length(x2)
for m=1:N2
 for l=1:n
   PHI_val(m,l)=x2(m).^(l-1);
 end
end

%3
theta_id=PHI_id\y';
%theta_val=linsolve(PHI_val,y2');
% 4
y_id=PHI_id*theta_id;
y_val=PHI_val*theta_id;

% 5
s1=0;
s2=0;
for a=1:length(y)
   s1=s1+(y(a)-y_id(a))^2;
end
for a=1:length(y2)
   s2=s2+(y2(a)-y_val(a))^2;
end
MSE_id=(1/N1)*s1
MSE_val=(1/N2)*s2
mse_vector(n)=MSE_val;
 end
%6
figure
plot(x2,y2,x2,y_val);
title('y validare vs y aproximare')
 


min2=mse_vector(1);
for j=1:25
    
    if(mse_vector(j)<min2)
        min2=mse_vector(j); 
        poz=j;
    end
end
figure
plot(mse_vector) 
title('vector mse')
hold on
plot(poz,min2,'r*')


