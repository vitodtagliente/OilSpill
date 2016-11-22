
% Questo script si occupa di automatizzare in completo 
% l'operazione di estrazione delle features

% img: rappresenta l'immagine segmentata in input all'algoritmo

function[] = spillfeatures( img )

% Calcola le 4 categorie di features

% 1. Features Geometriche
[perim, area, complexity, FIPM, EL, EW, EA] = spillgeom( img );

