
% --------- Caricamento dell'immagine

load('Test.mat');
s = spilltif('Test.tif', 1, 1, Rect );

% imshow( s.gsubI );

% hist(double(s.subIdB(:)),500);

% --------- Pre-processing delle macchie

% Memorizzo i rettangoli di crop
spill.Rect = CELL_RECT{1,1};
lookalike.Rect = CELL_RECT{1,2};

% Eseguo il crop sulle macchie
spill.Isigma = imcrop(s.subI, spill.Rect);
lookalike.Isigma = imcrop(s.subI, lookalike.Rect);

% Eseguo il crop delle maschere forniteci
spill.Mask = imcrop(SlickMask, spill.Rect);
lookalike.Mask = imcrop(SlickMask, lookalike.Rect);

% Conversione in dB
spill.dB = mag2db(spill.Isigma)/2;
lookalike.dB = mag2db(lookalike.Isigma)/2;

% Conversione in scala di grigi
spill.grayscale = mat2gray(spill.dB);
lookalike.grayscale = mat2gray(lookalike.dB);

% Calcolo della maschera del background
spill.foreMask = (spill.Mask == 0);
lookalike.foreMask = (lookalike.Mask == 0);

% Calcolo del background in scala di grgi
spill.gforeground = spill.grayscale .* spill.foreMask;
lookalike.gforeground = lookalike.grayscale .* lookalike.foreMask;

% Calcolo della macchia in scala di grigi
spill.gspill = spill.grayscale - spill.gforeground;
lookalike.gspill = lookalike.grayscale - lookalike.gforeground;

% Calcolo del background in dB
spill.foredB = spill.dB .* spill.foreMask;
lookalike.foredB = lookalike.dB .* lookalike.foreMask;

% Calcolo della macchia in dB
spill.spilldB = spill.dB - spill.foredB;
lookalike.spilldB = lookalike.dB - lookalike.foredB;

% Estrazione delle proprietà della figura
spill.props = regionprops( spill.Mask, 'all' );
lookalike.props = regionprops( lookalike.Mask, 'all' );

% Fetures geometriche
spill.geom = spillgeom( spill.Mask );
lookalike.geom = spillgeom( lookalike.Mask );

% --------- Stampa 1
% TODO: Ellisse

figure;

subplot(1,2,1);
hold on;
imshow(spill.Mask);
plot(spill.props.Centroid(1), spill.props.Centroid(2), 'g.', 'MarkerSize', 20);
rectangle('Position', spill.props.BoundingBox, 'EdgeColor', 'b', 'LineWidth', 2);
hold off;

subplot(1,2,2);
hold on;
imshow(lookalike.Mask);
plot(lookalike.props.Centroid(1), lookalike.props.Centroid(2), 'g.', 'MarkerSize', 20);    
rectangle('Position', lookalike.props.BoundingBox, 'EdgeColor', 'b', 'LineWidth', 2);
hold off;

% Features Texture
spill.texture = spilltexture( spill.gspill );
lookalike.texture = spilltexture( lookalike.gspill );

% Features Backscatter
spill.backscatter = spillbackscatter( spill.spilldB, spill.foredB ); 
lookalike.backscatter = spillbackscatter( lookalike.spilldB, lookalike.foredB );







