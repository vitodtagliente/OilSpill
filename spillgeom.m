
% Script per il calcolo delle features di natura geometrica

function [perim, area, complexity] = spillgeom( img )
% Calcolo del perimetro
[perim, perim_img] = spillperim( img );

% Calcolo dell'area
area = spillarea( img );

% Calcolo della complessità dell'oggetto
% This feature will take a small numerical value for regions with simple
% geometry and larger values for complex geometrical regions.
complexity = perim / (2 * sqrt( pi * area ));

