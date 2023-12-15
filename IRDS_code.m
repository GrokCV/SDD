% 2023-12-13
% This matlab code implements the IRDS model for infrared small target detection
% Author: Fei Zhou

clc;
clear;
close all;
addpath('IRDS-code')
addpath('functions/')
addpath('datas/')
% addpath('IRDS-code/datas/Seq2')
mm=1;%%%tuning the sequence number
datapath = ['datas/Seq' num2str(mm) '/'];
switch mm
    case 1
imgDir = dir([datapath '*.bmp']);
    case 2
 imgDir = dir([datapath '*.png']);      
end
len = length(imgDir);
%% input IR image/sequence
 for i = 1:len
     try
     img=imread(strcat(datapath,[num2str(i),'.bmp'])); 
     catch
      img=imread(strcat(datapath,[num2str(i),'.png'])); 
     end
     nn = ndims(img);
      if nn==3
          img= rgb2gray(img);
      end
      img = double(img);
     [m,n] = size(img);
     D(:,:,i) = img;
%%%%constructing global features
   [lambda1, lambda2] = structure_tensor_lambda(img, 'Gaussian', 2);
      t=0.01;
   temp_lamm = lambda1.*lambda2;
   temp_lama = lambda1+lambda2+0.01;
%%%%% constructing adaptive saliency coherence exponent function 
    
   temp_lamb = lambda1-lambda2+0.01;
   C1 = sqrt(temp_lamm);   
   C2 = abs(temp_lama./temp_lamb.^(1/2));  
   C3 = temp_lamm./temp_lama.^(1/2);
   
   harriTren = 1-exp(-t*(C1+C2+C3));

      WstrucTen(:,:,i)=harriTren;

    end
    
    %% Performing target-background separation 
%%%%%
opts=[];
opts.R       = 10;
opts.rho     = 0.001;
opts.tau     = 0.2;
opts.lambda  = 0.5;
opts.beta    = 15000;
opts.mu      = 0.05;
opts.max_it  = 20;
opts.Bmax_it = 10;
opts.tol     = 1e-4;
%.Xtrue   = Ohsi;
%%%%%
tic
[Re_hsi,A,tenB,tenS,D] = Mixed_sparse_dec(D, opts,WstrucTen);

  for ii = 1:len
      %%%%% target separation
         T_out = tenS(:,:,ii);
       thr = mean(T_out(:))+2*std(T_out(:));
       recTar =T_out.* ((T_out-thr)>0);
         figure; imshow(recTar);
          set(gca,'xtick',[],'xticklabel',[])
        set(gca,'ytick',[],'xticklabel',[])

  end
    

