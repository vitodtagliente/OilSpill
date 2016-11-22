
% Questo script esegue la conversione dell'immagine
% da formato RGB a formato binario/grayscale

function [imgbin] = spillbin( img )

imgbin = img;

if size(img, 3) == 3 % vuol dire che l'immagine è RGB
    level = graythresh(img);
    imgbin = im2bw(img, level);   
end