function [Ims Kms] = Ms(I,bandwidth)

%% Mean Shift Segmentation (option: bandwidth)
I = im2double(I);
X = reshape(I,size(I,1)*size(I,2),1);                                         % Color Features
%% MeanShift
[clustCent,point2cluster,clustMembsCell] = MeanShift_Helper(X',bandwidth);    % MeanShiftCluster X' each column is a point
clustCent
for i = 1:length(clustMembsCell)                                              % Replace Image Colors With Cluster Centers
X(clustMembsCell{i},:) = repmat(clustCent(:,i)',size(clustMembsCell{i},2),1); 
end
Ims = reshape(X,size(I,1),size(I,2),1);                                         % Segmented Image
Kms = length(clustMembsCell);

end
