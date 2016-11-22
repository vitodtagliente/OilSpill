
% First Invariant Planar Moment (FIPM)

function [FIPM] = spillfipm( img )
% n the number of points in the dark patch contour.
% Quindi lavoriamo solo con i pixel del contorno
[length, perim] = spillperim( img );
% Numero di pixel pari a 1 dell'immagine
n = numel( perim(:) ); 

% Dimensioni dell'immagine
[nrows, ncols] = size( img );

% Calcolo xc e yc
xc = 0;
yc = 0;
for j = 1:ncols
    for i = 1:nrows        
        if perim(i, j) == 1
           xc = xc + i;
           yc = yc + j;           
        end
    end
end

xc = xc / n;
yc = yc / n;

% Calcolo di FIPM
FIPM = 0;
for j = 1:ncols
    for i = 1:nrows        
        if perim(i, j) == 1
           FIPM = FIPM + ( (i - xc)^2 + (j - yc)^2 );         
        end
    end
end
FIPM = FIPM / ( n ^ 2 );

