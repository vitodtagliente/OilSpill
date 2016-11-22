
% Utilizza questo script per caricare e 
% segmentare l'immagine in input

% img: immagine originale
img = imread( 'oil.bmp' );
% s: immagine segmentata
s = spillseg( img );