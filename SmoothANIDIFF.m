%SmoothANIDIFF Image smoothing using standard anisotropic diffusion.
%
%    imgSMOOTH = SmoothANIDIFF(img,nIT,cc,ds,opt);  
%
%INPUT   
%    img        : image to be smoothed;
%    nIT        : number of iterations (e.g. 4);
%     cc        : conduction coeficient between [10;100] (e.g. 60);
%     ds        : a constant that controls the diffusion speed [0;0.25] (e.g. 0.25);
%    opt        : '1' when privileging high-contrast edges over low-contrast ones or 
%                 '2' when privileging wide regions over smaller ones (preferable).
%OUTPUT
%    imgSMOOTH  : smoothed image using anisotropic diffusion;
%
%DESCRIPTION
%  This function smoothes an entire image using standard anisotropic diffusion technique.
%  It processes the images at pixel level. See references for theoretical details.
%
%EXAMPLES
%    imgSMOOTH = SmoothANIDIFF(Crack001,4,60,0.25,2);
%
%SEE ALSO
% SmoothRUINTA | SmoothERODEOPEN | SmoothMORFO | SmoothWAVESYM
%       
%REFERENCES 
% 1) P. Perona and J. Malik, "Scale-Space and Edge Detection Using Anisotropic Diffusion",
% IEEE TRANSACTIONS ON PATTERN ANALYSIS AND MACHINE INTELLIGENCE, VOL. 12, NO. 7, 
% pp. 629-639, JULY 1990
% 
% 2) H. Oliveira and P.L. Correia, "Automatic Crack Detection on Road Imagery Using Anisotropic 
% Diffusion and Region Linkage", Proceedings European Signal Processing Conference - EUSIPCO, 
% Aalborg, Denmark, August, 2010
%
%VERSION
% CrackIT -> v1.5
% 1-May-2016 21:47:13 -> MatLab R2015b (64-bit)

function imgSMOOTH = SmoothANIDIFF(img,nIT,cc,ds,opt)

%% Check variables:
if nargin ~= 5
    error('STOP: Wrong number of function parameters! You must supply five parameters!');
end
if ~isa(img,'uint8')
    error('STOP: Input image must be an 8-bit unsigned integer array!');
elseif max(img(:)) <= 1
    error('STOP: It appears that gray levels are between 0 and 1. Please use the range [0;255]!')
elseif numel(size(img)) > 2
    error('STOP: It appears that the input image is not a 2D array! Please converte it to a 2D array in grayscale!');     
end
if numel(nIT) > 1 || (nIT - fix(nIT) ~= 0) || (nIT < 1)
    error('STOP: Wrong ''nIT'' parameter. It must be a potivive integer (nonzero)!');
end
if numel(cc) > 1 || (cc - fix(cc) ~= 0) || cc < 10 || cc > 100
    error('STOP: Wrong ''cc'' parameter. It must be a potivive integer (nonzero) between 10 and 100!');
end
if numel(ds) > 1 || ds <= 0 || ds > 0.25
    error('STOP: Wrong ''ds'' parameter. It must be a real value whiting 0 and 0.25!');
end
if numel(opt) > 1 || ~any(opt == [1 2]);
    error('STOP: Wrong ''opt'' parameter. It must be an integer: 1 or 2!');
end

%% Prompt:
fprintf('\nAnisotropic Diffusion Smoothing:\n');
fprintf(' Input parameters:\n');
fprintf('  Number of iterations: %i\n',nIT);
fprintf('  Conduction coeficient: %i\n',cc);
fprintf('  Diffusion speed: %0.2f \n',ds);
if opt == 1
    rp = 'Privileging high-contrast edges over low-contrast ones!';
else
    rp = 'Privileging wide regions over smaller ones!';
end
fprintf('  Method: %s\n',rp);

%% Convert input image to double.
img = double(img);

%% PDE (partial differential equation) initial condition.
imgSMOOTH = img;

%% Center pixel distances.
dx = 1;
dy = 1;
dd = sqrt(2);

%% 2D convolution masks - finite differences.
hN = [0 1 0; 0 -1 0; 0 0 0];
hS = [0 0 0; 0 -1 0; 0 1 0];
hE = [0 0 0; 0 -1 1; 0 0 0];
hW = [0 0 0; 1 -1 0; 0 0 0];
hNE = [0 0 1; 0 -1 0; 0 0 0];
hSE = [0 0 0; 0 -1 0; 0 0 1];
hSW = [0 0 0; 0 -1 0; 1 0 0];
hNW = [1 0 0; 0 -1 0; 0 0 0];

%% Anisotropic diffusion.
t00 = now;
for t = 1:nIT

        % Prompt:
        fprintf('   Iteration %d... ',t);
        
        % Finite differences. [imfilter(.,.,'conv') can be replaced by conv2(.,.,'same')]
        nablaN = imfilter(imgSMOOTH,hN,'conv');
        nablaS = imfilter(imgSMOOTH,hS,'conv');   
        nablaW = imfilter(imgSMOOTH,hW,'conv');
        nablaE = imfilter(imgSMOOTH,hE,'conv');   
        nablaNE = imfilter(imgSMOOTH,hNE,'conv');
        nablaSE = imfilter(imgSMOOTH,hSE,'conv');   
        nablaSW = imfilter(imgSMOOTH,hSW,'conv');
        nablaNW = imfilter(imgSMOOTH,hNW,'conv'); 
        
        % Diffusion function.
        if opt == 1
            cN = exp(-(nablaN/cc).^2);
            cS = exp(-(nablaS/cc).^2);
            cW = exp(-(nablaW/cc).^2);
            cE = exp(-(nablaE/cc).^2);
            cNE = exp(-(nablaNE/cc).^2);
            cSE = exp(-(nablaSE/cc).^2);
            cSW = exp(-(nablaSW/cc).^2);
            cNW = exp(-(nablaNW/cc).^2);
        elseif opt == 2
            cN = 1./(1 + (nablaN/cc).^2);
            cS = 1./(1 + (nablaS/cc).^2);
            cW = 1./(1 + (nablaW/cc).^2);
            cE = 1./(1 + (nablaE/cc).^2);
            cNE = 1./(1 + (nablaNE/cc).^2);
            cSE = 1./(1 + (nablaSE/cc).^2);
            cSW = 1./(1 + (nablaSW/cc).^2);
            cNW = 1./(1 + (nablaNW/cc).^2);
        end

        % Discrete PDE solution.
        imgSMOOTH = imgSMOOTH + ...
                  ds*(...
                  (1/(dy^2))*cN.*nablaN + (1/(dy^2))*cS.*nablaS + ...
                  (1/(dx^2))*cW.*nablaW + (1/(dx^2))*cE.*nablaE + ...
                  (1/(dd^2))*cNE.*nablaNE + (1/(dd^2))*cSE.*nablaSE + ...
                  (1/(dd^2))*cSW.*nablaSW + (1/(dd^2))*cNW.*nablaNW );
           
        % Iteration warning.
        fprintf('Done!\n');
end

%% Converting to an 8-bit unsigned integer array:
imgSMOOTH = uint8(imgSMOOTH);

%% Prompt:
fprintf('   **************> Full image smoothing (AniDiff) in -> %s %s!\n',...
    datestr(now-t00, 'HH:MM:SS.FFF'),'(HH:MM:SS.FFF)');

%% EOF