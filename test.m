
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

% Features Backscatter di confronto
spill.extra.LocalContrast = spill.backscatter.BackMean - spill.backscatter.SpillMean;
lookalike.extra.LocalContrast = lookalike.backscatter.BackMean - lookalike.backscatter.SpillMean;

spill.extra.WindowHomogeneity = spill.backscatter.BackStandardDeviation - spill.backscatter.BackMean;
lookalike.extra.WindowHomogeneity = lookalike.backscatter.BackStandardDeviation - lookalike.backscatter.BackMean;

spill.extra.SlickHomogeneity = spill.backscatter.SpillStandardDeviation - spill.backscatter.SpillMean;
lookalike.extra.SlickHomogeneity = lookalike.backscatter.SpillStandardDeviation - lookalike.backscatter.SpillMean;

% Features Ancillari

SpikeCenterList = 1.0e+03 *[
0.579675930200000 0.999716705270131
0.840660709104075 0.905354539480441
0.941961252345276 0.181831165539384
1.676143092474878 1.260116949458680];

v = regionprops(SlickMask, 'all' );
spill.context.x = v(1).Centroid(1);
spill.context.y = v(1).Centroid(2);

xspikes = SpikeCenterList(:,1) - spill.context.x;
yspikes = SpikeCenterList(:,2) - spill.context.y;

dist = (xspikes).^2 + (yspikes).^2;
spill.context.MinDistance =  min( sqrt( dist ) );

lookalike.context.x = v(2).Centroid(1);
lookalike.context.y = v(2).Centroid(2);

xspikes = SpikeCenterList(:,1) - lookalike.context.x;
yspikes = SpikeCenterList(:,2) - lookalike.context.y;

dist = (xspikes).^2 + (yspikes).^2;
lookalike.context.MinDistance =  min( sqrt( dist ) );

%%
figure;
imshow(SlickMask);
hold on;
plot(spill.context.x, spill.context.y, 'g.', 'MarkerSize', 20);
plot(lookalike.context.x, lookalike.context.y, 'g.', 'MarkerSize', 20);
for i=1:4
    plot(SpikeCenterList(i, 1), SpikeCenterList(i, 2), 'r.', 'MarkerSize',20);
end
%%

