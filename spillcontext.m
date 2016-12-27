
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

% Number of bright spots nearby
dim = size(spikes);
out.spotsCount = dim(1);

%calcolo centroide della macchia di petrolio
spill=regionprops(s.spillMask,'all');
temp = cat(1, spill.Centroid);
x=temp(:,1);
y=temp(:,2);
centroid=[mean(x),mean(y)];
out.spillCentroid = centroid;

% Distance to next bright spot (vessel, platform)
temp=cat(1,spikes.Centroid);
xspikes=temp(:,1);
yspikes=temp(:,2);
xspikes = xspikes - centroid(1);
yspikes = yspikes - centroid(2);
dist = (xspikes).^2 + (yspikes).^2;
vdist = sqrt(dist);
out.nextSpotDistance = min(vdist);

if debug 
    figure;
    imshow(s.gsubI);
    hold on;
    plot(centroid(1), centroid(2), 'g.', 'MarkerSize', 20);
    for i=1:out.spotsCount
        plot(spikes(i).Centroid(1), spikes(i).Centroid(2), 'r.', 'MarkerSize',20);
    end
end
% Distance from land
coastMask=importBNAdata;    %import dei dati della costa in formato bna per zona della macchia di petrolio
[l,coastMask]=spillperim(coastMask); %estrazione dei soli punti del perimetro della costa


