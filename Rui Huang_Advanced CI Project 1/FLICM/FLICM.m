function I = FLICM(I,r,numOfCluster)
[m,n]=size(I); 
width = 2*r + 1
[windows,Distances]=createWindows(I,width); % Distances is a matrix that contain the distance between element in the window and the window center
I=double(I);
data = reshape(I, numel(I), 1); 
parameters=[2;300;1e-5;0];               
[V,U,obj_fcn,iter_n]=FLICM_Helper(data,windows,Distances,numOfCluster,parameters);
[~, label] = max(U', [], 2);
I = uint8(reshape(V(label, :), m, n));

