function img = FCM(I,K,b)
[m, n, p] = size(I);
X = reshape(double(I), m*n, p);
[C, dist, J] = FCM_Helper(X, K, b);
C
size(dist)
[~, label] = min(dist, [], 2);
%figure
%imshow(uint8(reshape(C(label, :), m, n, p)))
img = uint8(reshape(C(label, :), m, n, p));
figure(2)
plot(1:length(J), J, 'r-*'), xlabel('#iterations'), ylabel('objective function')
end
