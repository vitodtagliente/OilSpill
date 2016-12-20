
% Script per il caricamento e l'elaborazione delle
% immagini TIF, modifca di quello passatoci
% dal Professore

function [out] = spilltif( filename, IdData, FLAG_Crop )
% il parametro debug è opzionale
if nargin <= 1
    IdData = 1;
    FLAG_Crop = 1;
end

[Istack Rs] = geotiffread(filename);
Isigma=Istack(:,:,IdData);
%DEM=Istack(:,:,IdDem);

%costruzione della griglia di lat long per l'immagine sentinel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lat=[Rs.Latlim(2):Rs.DeltaLat:Rs.Latlim(1)-Rs.DeltaLat/2];
lon=[Rs.Lonlim(1):Rs.DeltaLon:Rs.Lonlim(2)-Rs.DeltaLon/2];
%lat=[Rs.Latlim(2):Rs.DeltaLat:Rs.Latlim(1)];
%lat(end)=[];
%lon=[Rs.Lonlim(1):Rs.DeltaLon:Rs.Lonlim(2)];
[LONGITUDE ,LATITUDE]=meshgrid(lon,lat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% sostituzione 0->nan gestione dei nodata
% Inan=find(DEM<=-2.277e+04);
% Isent(Inan)=nan;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% se esistono le matrici di latitude e  longitude
%% prodotte da sentinel toolbox
% a=Istack(:,:,4); % latitude
% b=Istack(:,:,5); % longitude
% figure,imagesc(a)
% figure,imagesc(b)
% % indici dei nodata
% Inan1=find(a==0 & b==0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure,imagesc(DEM);axis image
figure,imagesc(Isigma);axis image,colormap gray
caxis([0 nanmean(Isigma(:))])



if FLAG_Crop==1

    % La seguente istruzione ci permette di eseguire
    % il crop manuale da editor visuale
    [subI Rect]=imcrop; 
    % Altrimenti possiamo definire la finestra 
    % di crop in questo modo: 
    % imcrop(I,[75 68 130 112]);
    SUB_LAT=imcrop(LATITUDE,Rect);
    SUB_LON=imcrop(LONGITUDE,Rect);
else
    subI=Isigma;
    SUB_LAT=LATITUDE;
    SUB_LON=LONGITUDE;    
end

%% output

out.Istack = Istack;
out.Rs = Rs;
% Informazioni su Isigma
out.Isigma = Isigma;
out.IsigmadB = mag2db(Isigma)/2;
% Isigma in grayscale
out.gIsigma = mat2gray(out.IsigmadB);
out.Lon = LONGITUDE;
out.Lat = LATITUDE;
% Informazioni sul crop di Isigma
out.SubLat = SUB_LAT;
out.SubLon = SUB_LON;
out.subI = subI;
out.subIdB = mag2db(subI)/2;
% subI in grayscale
out.gsubI = mat2gray(out.subIdB);
out.Rect = Rect;
% Maschere
out.spillMask = (out.subIdB >- 20);
%out.backMask = (out.spillMask * -1) + 1;
out.backMask = (out.spillMask == 0);
% Background in scala di grigi
out.gback = out.gsubI .* out.spillMask;
% Macchia di petrolio in scala di grigi
out.gspill = out.gsubI - out.gback;

%% 

%clear Istack
%clear LATITUDE
%clear LONGITUDE

%figure,imagesc(subI);axis image,colormap gray
%caxis([0 nanmean(subI(:))])


%% visualizzazione in coordinate geografiche
%figure
%figure,geoshow(SUB_LAT,SUB_LON,subI);axis image

%% registra il crop per la riproducibilita
%Rcrop=Rect;
