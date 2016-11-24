
% Calcolo dei parametri basati sulla Matrice di 
% co-occorrenza dei livelli di grigio

function [ out ] = spilltexture(img)
out.GLCM = graycomatrix(img);

% Codice base di Matlab
% stats = graycoprops(glcm);
% stats.Homogeneity

% Le features sono state calcolate utilizzando
% uno script esterno

features = glcmfeatures( out.GLCM, 0 );

% 1. Homogeneity
out.Homogeneity = features.homom;

% 2. Contrast
out.Contrast = features.contr;

% 3. Entropy
out.Entropy = features.entro;

% 4. Correlation
out.Correlation = features.corrm;

% 5. Dissimilarity
out.Dissimilarity = features.dissi;
