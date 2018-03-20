function [windows,Distance]=createWindows(I,width)
[m,n]=size(I);
I=zeros(m,n);
I(:)=1:m*n;    
center=floor(width/2)+1;   
for i=1:width
    for j=1:width
        Distance((j-1)*width+i)=sqrt((i-center)^2+(j-center)^2);%使用到矩阵的线性寻址
    end
end
Distance=Distance';
halfSizeOfWindow=floor(width/2);
paddingImg=[I(:,1:halfSizeOfWindow), I, I(:,(end-halfSizeOfWindow+1):end)];  
paddingImg=[paddingImg(1:halfSizeOfWindow,:); paddingImg; paddingImg(end-halfSizeOfWindow+1:end,:)]; 
windows=zeros(width*width,m*n);
for i=1:m
    for j=1:n
        temp=paddingImg(i:i+2*halfSizeOfWindow,j:j+2*halfSizeOfWindow);
        windows(:,(j-1)*m+i)=temp(:);                    %矩阵线性寻址
    end
end
centerPosition=(center-1)*width+center;
Distance(centerPosition)=[];                  
windows(centerPosition,:)=[];
        