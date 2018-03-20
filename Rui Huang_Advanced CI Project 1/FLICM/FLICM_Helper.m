function [V,U,obj_fcn,iter_n]=FLICM_Helper(data,windows,Distances,numOfCluster,parameters)
numOfData=size(data,1);
m=parameters(1);       
max_iter=parameters(2);   
min_impro=parameters(3);
obj_fcn=zeros(max_iter,1);
U=initU(numOfCluster,numOfData);
for i=1:max_iter
    Uold=U;
    [U,V,obj_fcn(i)]=update(data,windows,Distances,U,numOfCluster,m);%调用函数进行一步迭代
    if i>1
        if(norm(U-Uold,Inf))< min_impro
            break;
        end
    end
end
iter_n=i;     
obj_fcn(iter_n+1:max_iter)=[];



function U=initU(numOfCluster,numOfData)
U=rand(numOfCluster,numOfData);
col_sum=sum(U);         
U=U./col_sum(ones(numOfCluster,1),:);


function [U,center,obj_fcn]=update(data,windows,Distance,Uold,numOfCluster,expo)
[m,n]=size(windows);
mf=Uold.^expo;
center=mf*data./((ones(size(data,2),1)*sum(mf'))');
dist=getDist(center,data);
Distance=repmat(Distance,1,n);
for i=1:numOfCluster
    UKJ=Uold(i,windows);
    UKJ=reshape(UKJ,m,n);
    distKJ=dist(i,windows);
    distKJ=reshape(distKJ,m,n);
    G(i,:)=sum(((1-UKJ).^expo).*(distKJ.^2)./(Distance+1));
end
obj_fcn=sum(    sum(     (dist.^2).*mf + G      )    );
tempb=(dist.^2+1*G).^(-1/(expo-1));
U=tempb./(ones(numOfCluster,1)*sum(tempb));


function distMatrix=getDist(center,data)
distMatrix=zeros(size(center,1),size(data,1));
if size(center,2)>1%
    for k=1:size(center,1)
        distMatrix(k,:)=sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)'));
    end
else
    for k=1:size(center,1)
        distMatrix(k,:)=abs(center(k)-data)';
    end
end