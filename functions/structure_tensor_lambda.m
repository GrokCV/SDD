function [lambda_1, lambda_2] = structure_tensor_lambda(img, filter_type, pat_wid)

[img_hei, img_wid] = size(img);
G = fspecial('gaussian', [pat_wid pat_wid], 1.2); % Gaussian kernel
u = imfilter(img, G, 'symmetric');
% u = img;
t = 2;                  % Search_size : 2*t+1;
f = 1;                  % Patch size  : 2*f+1;
h1 = 1;                 % Standard deviation of Gaussian kernel
h2 = 0.2;               % Threshold for distance
selfsim = 0;
W=cal_W(u,t,f,h1,h2,selfsim);

[Gx, Gy] = gradient(u);
J_rho = zeros(img_hei, img_wid, 2, 2);    

% J_rho(:,:,1,1) = Gx.^2;
% J_rho(:,:,1,2) =  Gx.*Gy;
% J_rho(:,:,2,1) = J_rho(:,:,1,2);
% J_rho(:,:,2,2) = Gy.*Gy; 

if isequal(filter_type, 'Gaussian')
    K = fspecial('gaussian', [pat_wid pat_wid], 2); % Gaussian kernel
    J_rho(:,:,1,1) = imfilter(Gx.^2, K, 'symmetric'); 
    J_rho(:,:,1,2) =  imfilter(Gx.*Gy, K, 'symmetric');
    J_rho(:,:,2,1) = J_rho(:,:,1,2);
    J_rho(:,:,2,2) = imfilter(Gy.*Gy, K, 'symmetric');
elseif isequal(filter_type, 'Wiener')
    J_rho(:,:,1,1) = wiener2(Gx.^2, [pat_wid pat_wid]);
    J_rho(:,:,1,2) =  wiener2(Gx.*Gy, [pat_wid pat_wid]);
    J_rho(:,:,2,1) = J_rho(:,:,1,2);
    J_rho(:,:,2,2) = wiener2(Gy.*Gy, [pat_wid pat_wid]);   
elseif isequal(filter_type, 'Nolocal_tensor')
     J_rho(:,:,1,1) = reshape(W*Gx(:).^2, img_hei, img_wid);
    J_rho(:,:,1,2) = reshape( W*Gx(:).*Gy(:),img_hei, img_wid);
    J_rho(:,:,2,1) = J_rho(:,:,1,2);
    J_rho(:,:,2,2) = reshape(W*Gy(:).*Gy(:),img_hei, img_wid);   
end

sqrt_delta = sqrt((J_rho(:,:,1,1) - J_rho(:,:,2,2)).^2 + 4*J_rho(:,:,1,2).^2);
lambda_1 = 0.5*(J_rho(:,:,1,1) + J_rho(:,:,2,2) + sqrt_delta);
lambda_2 = 0.5*(J_rho(:,:,1,1) + J_rho(:,:,2,2) - sqrt_delta);