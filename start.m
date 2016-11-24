
% Utilizza questo script per caricare e 
% segmentare l'immagine in input

% img: immagine originale
img = imread( 'oil.bmp' );
% gray: immagine non segmentata in scala di grigi
gimg = rgb2gray( img );
% s: immagine segmentata
s = spillseg( img );

% Calcolo dell'immagine di background
back = spillback( img, s );
% Immagine di background in scala di grigi
gback = rgb2gray( back );