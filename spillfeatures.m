
% Questo script si occupa di automatizzare in completo 
% l'operazione di estrazione delle features

% spill: l'immagine della macchia di petrolio in scala di grigi
% back: sfondo dell'immagine in scala di grigi
% seg: spill segmentato in formato binario

function [ features ] = spillfeatures( spill, back, seg )

% Calcola le 4 categorie di features

% 1. Geometrical Features
features.Geometrical = spillgeom( seg );

% 2. Backscatter Features
features.Backscatter = spillbackscatter( spill, back );

% 3. Texture Features
features.Texture = spilltexture( spill );
