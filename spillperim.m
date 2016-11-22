
% Questo script si occupa di ricavare il perimetro
% dell'oggetto in input

function [length, perim_img] = spillperim( img, debug )
% il parametro debug è opzionale
if nargin <= 1
   debug = false; 
end

% L'oggetto in input deve essere binario
temp = spillbin( img );

% Produco l'immagine contenete il bordo dell'oggetto
perim_img = bwperim( temp );

% Debug grafico
if debug
    imshow(perim_img);
end

% Calcolo il perimetro
length = sum( int32( perim_img(:) ) );
