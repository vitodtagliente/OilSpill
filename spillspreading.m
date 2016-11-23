
% this feature is derived from the principal component
% analysis of the vectors whose components are the 
% coordinates of the pixels belonging to the dark patch
% (see [24] for details). Feature S will be low for
% long and thin objects and high for objects closer 
% to a circular shape.

function [result] = spillspreading( img )
% Lavoriamo solo con i pixel del contorno
[length, perim] = spillperim( img );

