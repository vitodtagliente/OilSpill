
% Utilizza questo script per preparare il Workspace di Matlab

% img: immagine originale
img = imread( 'oil.bmp' );
% gimg: immagine non segmentata in scala di grigi
gimg = rgb2gray( img );
% s: immagine segmentata
s = spillseg( img );

% back: immagine di background
back = spillback( img, s );
% gback: immagine di background in scala di grigi
gback = rgb2gray( back );
% gspill: macchia di petrolio in scala di grigi
gspill = gimg - gback;