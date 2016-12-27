
% Questo script si occupa di automatizzare in completo 
% l'operazione di estrazione delle features

% spill: l'immagine della macchia di petrolio in scala di grigi
% back: sfondo dell'immagine in scala di grigi
% seg: spill segmentato in formato binario

function [ features ] = spillfeatures( s )

% Calcola le 4 categorie di features

% 1. Geometrical Features
features.Geometrical = spillgeom( s.spillMask );

% 2. Backscatter Features
features.Backscatter = spillbackscatter( s.ispill, s.iback );

% 3. Texture Features
features.Texture = spilltexture( s.gspill );

% 4. Context Features
features.Context = spillcontext( s );
