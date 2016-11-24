
% Utilizza questo script per caricare e 
% segmentare l'immagine in input

% img: immagine originale
img = imread( 'oil.bmp' );
% gray: immagine non segmentata in scala di grigi
gimg = rgb2gray( img );
% s: immagine segmentata
s = spillseg( img );