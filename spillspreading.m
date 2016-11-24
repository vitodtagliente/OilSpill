
% this feature is derived from the principal component
% analysis of the vectors whose components are the 
% coordinates of the pixels belonging to the dark patch
% (see [24] for details). Feature S will be low for
% long and thin objects and high for objects closer 
% to a circular shape.

% It is derived from the principal components analysis
% [6] of the vectors whose components are the
% coordinates of the pixels belonging to the object. 
% If ?1 and ?2 are the two eigenvalues associated 
% with the computed covariance matrix and ?1> ?2
% the spreading value S is computed using 
% the expression:
% S = 100?2 /( ?1 + ?2 ) 

function [result] = spillspreading( img )
% Lavoriamo solo con i pixel del contorno
[length, pimg] = spillperim( img );

% Calcolo della matrice di covarianza
% c = cov( pimg );

% Calcolo degli autovalori
% e = eig( c );

