
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

% Calcolo della maschera del background
spill.foreMask = (spill.Mask == 0);
lookalike.foreMask = (lookalike.Mask == 0);

% Estrazione delle proprietà della figura
spill.props = regionprops( spill.Mask, 'all' );
lookalike.props = regionprops( lookalike.Mask, 'all' );

% Calcolo dei BBox
spill.BBox = spill.props.BoundingBox;
spill.BBox(1)=spill.BBox(1)-10;
spill.BBox(2)=spill.BBox(2)-10;
spill.BBox(3)=spill.BBox(3)+20;
spill.BBox(4)=spill.BBox(4)+20;
spill.BBoxImage = imcrop(spill.Isigma, spill.BBox );

lookalike.BBox = lookalike.props.BoundingBox;
lookalike.BBox(1)=lookalike.BBox(1)-10;
lookalike.BBox(2)=lookalike.BBox(2)-10;
lookalike.BBox(3)=lookalike.BBox(3)+20;
lookalike.BBox(4)=lookalike.BBox(4)+20;
lookalike.BBoxImage = imcrop(lookalike.Isigma, lookalike.BBox );

% Ridimensionamento delle maschere
spill.bbMask = imcrop(spill.Mask, spill.BBox);
lookalike.bbMask = imcrop(lookalike.Mask, lookalike.BBox);
spill.bbforeMask = (spill.bbMask == 0);
lookalike.bbforeMask = (lookalike.bbMask == 0);

% Conversione in dB
spill.dB = mag2db(spill.Isigma)/2;
lookalike.dB = mag2db(lookalike.Isigma)/2;
spill.bbdB = mag2db(spill.BBoxImage)/2;
lookalike.bbdB = mag2db(lookalike.BBoxImage)/2;

% Calcolo del background in dB
spill.foredB = spill.bbdB .* spill.bbforeMask;
lookalike.foredB = lookalike.bbdB .* lookalike.bbforeMask;

% Calcolo della macchia in dB
spill.spilldB = spill.bbdB - spill.foredB;
lookalike.spilldB = lookalike.bbdB - lookalike.foredB;

% Conversione in scala di grigi
spill.grayscale = mat2gray(spill.bbdB);
lookalike.grayscale = mat2gray(lookalike.bbdB);

% #######################################

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
spill.texture = spilltexture( spill.grayscale );
lookalike.texture = spilltexture( lookalike.grayscale );

% Features Backscatter
spill.backscatter = spillbackscatter( spill.spilldB, spill.foredB ); 
lookalike.backscatter = spillbackscatter( lookalike.spilldB, lookalike.foredB );







