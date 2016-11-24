
% Script che calcola la matrice del background

function [b] = spillback( img, s )
b = img;
b(:,:,1)=img(:,:,1).*uint8(s);
b(:,:,2)=img(:,:,2).*uint8(s);
b(:,:,3)=img(:,:,3).*uint8(s);