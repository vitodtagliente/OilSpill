
% Script per l'estrazione delle features di
% contesto

function [out] = spillcontext( s, debug )
% il parametro debug è opzionale
if nargin <= 1
   debug = false; 
end

% Calcolo delle regioni a luminosità 
% più alta
mask = (s.subIdB < -10);
mask = (mask == 0);

spikes = regionprops(mask, 'all');

%% Number of bright spots nearby
dim = size(spikes);
out.spotsCount = dim(1);

%% calcolo centroide della macchia di petrolio
spill=regionprops(s.spillMask,'all');
temp = cat(1, spill.Centroid);
x=temp(:,1);
y=temp(:,2);
%coordinate del baricentro nel sistema di riferimento del crop dell'immagine di partenza
spillCropCentroid=[mean(x),mean(y)]; 
out.spillCropCentroid = spillCropCentroid;
%calcolo del baricentro nel sistema di riferimento dell'immagine di
%a dimensione originale. Si accede alla struttura Rect
%[xmin,ymin,width,height] e si sommano le coordinate del baricentro trovato
%a xmin e ymin (che rappresentano l'offset rispetto l'immagine di partenza
out.spillCentroid=[spillCropCentroid(1)+s.Rect(1),spillCropCentroid(2)+s.Rect(2)];

%% Distance to next bright spot (vessel, platform)
temp=cat(1,spikes.Centroid);
xspikes=temp(:,1);
yspikes=temp(:,2);
xspikes = xspikes - spillCropCentroid(1);
yspikes = yspikes - spillCropCentroid(2);
dist = (xspikes).^2 + (yspikes).^2;
vdist = sqrt(dist);
out.nextSpotDistance = min(vdist);

if debug 
    figure;
    imshow(s.gsubI);
    hold on;
    plot(spillCropCentroid(1), spillCropCentroid(2), 'g.', 'MarkerSize', 20);
    for i=1:out.spotsCount
        plot(spikes(i).Centroid(1), spikes(i).Centroid(2), 'r.', 'MarkerSize',20);
    end
end

%% Distance from land
%import dei dati della costa in formato bna 
% per zona della macchia di petrolio
coastMask=importBNAdata;
%estrazione dei soli punti del perimetro della costa    
[l,coastMask]=spillperim(coastMask); 
if debug
    figure;
    imshow(coastMask);
    hold on;
    plot(out.spillCentroid(1),out.spillCentroid(2),'g.','MarkerSize',20);
end

[dimx,dimy]=size(coastMask);
%inizializzo la distanza minima ad infinito
minDist=Inf;
for x=1:dimx
    for y=1:dimy
        if(coastMask(x,y))
            %trovato un punto in cui la maschera 
            % sia 1 = punto della costa
            tempDist=sqrt((x-out.spillCentroid(1))^2+(y-out.spillCentroid(2))^2);
            if(tempDist<minDist)
                minDist=tempDist;
            end
        end
    end
end
out.minDistFromLand=minDist;

