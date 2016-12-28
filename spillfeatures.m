
% Questo script si occupa di automatizzare in completo 
% l'operazione di estrazione delle features

% s: struttura dati ottenuta da spilltif

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
