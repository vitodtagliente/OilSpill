
% Script per il calcolo delle features di natura geometrica

function [perim, area, complexity, FIPM, EL, EW, EA] = spillgeom( img )
% 1. Calcolo del perimetro
[perim, perim_img] = spillperim( img );

% 2. Calcolo dell'area
area = spillarea( img );

% 3. Calcolo della complessità dell'oggetto
% This feature will take a small numerical value for regions with simple
% geometry and larger values for complex geometrical regions.
complexity = perim / (2 * sqrt( pi * area ));

% 4. Calcolo del FIPM
FIPM = spillfipm( img );

% 5. Calcolo dei parametri basati sull fitting dell'ellisse
% Ellipse Length: value of main axe of an ellipse fitted to the data
% Ellipse Width: value of minor axe of an ellipse fitted to the data.
[ EL, EW ] = spillellipfit( img );
% Ellipse Asymetry
EA = 1 - (EW / EL);

