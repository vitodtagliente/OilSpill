
% Calcolo dell'area dell'oggetto passato in input

function [area] = spillarea( img )

% L'oggetto in input deve essere binario
temp = spillbin( img );

% Calcolo dell'area
area = bwarea( temp );
