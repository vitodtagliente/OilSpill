
% Utilizza questo script per preparare il Workspace di Matlab

function [out] = spillbegin( filename )

% img: immagine originale
out.img = imread( filename );
% gimg: immagine non segmentata in scala di grigi
out.gimg = rgb2gray( out.img );
% s: immagine segmentata
out.s = spillseg( out.img );

% back: immagine di background
out.back = spillback( out.img, out.s );
% gback: immagine di background in scala di grigi
out.gback = rgb2gray( out.back );
% gspill: macchia di petrolio in scala di grigi
out.gspill = out.gimg - out.gback;