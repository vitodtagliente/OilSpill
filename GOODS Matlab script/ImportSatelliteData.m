clc
close all
clear all

%% codice che importa il dato geotiff sar o ottico
%% processato da stbx1 o envi
%% effettua un crop per eventuale analisi
%% e eventuali applicazioni di procedure da testare


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% case oil spill Golfo Mexico
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (1)

PATH_SAT='C:\Users\alberto\Desktop\morea\OilSlick\Golf_Mexico_ENVISAR'

% NameSAT='subset_0_of_ASA_WSM_1PNUPA20090726_161007_000000732081_00083_38714_6740.tif'
NameSAT='subset_1_of_ASA_WSM_1PNUPA20090726_161007_000000732081_00083_38714_6740.tif'
NameSAT='subset_3_of_ASA_WSM_1PNUPA20090726_161007_000000732081_00083_38714_6740.tif'
NameSAT='subset_2_of_ASA_WSM_1PNUPA20090726_161007_000000732081_00083_38714_6740.tif'
% % 
% % 
%NameSAT='Crop1_of_20090726_161007_Orb_Calib_Deb_Sub_Spkle_TC.tif'
%NameSAT='Crop2_of_20090726_161007_Orb_Calib_Deb_Sub_Spkle_TC.tif'
IdData=1
IdDem=2
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% case oil spill california  dataset sentinel
if (0)
PATH_SAT='C:\Users\alberto\Desktop\morea\OilSlick\California_Case\GeoTIFF\Sentinel1A'
NameSAT='subset_0_of_S1A_IW_SLC__1SSV_20150823T140016_20150823T140044_007391_00A2A6_1450_IW2_DEM_TC.tif'
IdData=1
end
%% case oil spill california  dataset landsat8
if (0)
PATH_SAT='C:\Users\alberto\Desktop\morea\OilSlick\California_Case\GeoTIFF\Landsat8'
NameSAT='subset_1_of_LC80420362015226LGN00_subset_DEM_reprojected.tif'
IdData=2

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% case oil spill Bohai sea case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (0)
PATH_SAT='C:\Users\alberto\Desktop\morea\OilSlick\Bohai_Sea_Case\Bohai'
 
NameSAT='Crop_Fig2c_of_20110619_022140_Orb_Calib_Deb_Sub_Spkle_TC.tif'
%NameSAT='Crop_Fig2b_of_20110614_020503_Orb_Calib_Deb_Sub_Spkle_TC.tif'
IdData=1
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% case oil spill guimaires island case
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (0)
PATH_SAT='C:\Users\alberto\Desktop\morea\OilSlick\GuimarasIsland_Case'
NameSAT='Crop_Fig5a_of_20060824_014438_Orb_Calib_Deb_Sub_Spkle_TC.tif'
%NameSAT='Crop1_of_20060825_135315_Orb_Calib_Deb_Sub_Spkle_TC.tif'
%NameSAT='Crop_Fig5b_of_20060824_014438_Orb_Calib_Deb_Sub_Spkle_TC.tif'
%NameSAT='Crop_Fig5c_of_20060828_135854_Orb_Calib_Deb_Sub_Spkle_TC.tif'
IdData=1
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% case oil spill Sentinel1 NAPOLI dataset
%% path dati
if (0)
PATH_SAT='C:\Users\alberto\Desktop\morea\OilSlick\CasesOfSutudies\DataProcessing\Output\SAR_Data\S1A\SLC\Napoli_It\S1TBX_Output\GeoTIFF\out_20150815T051150\'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% immagini sentinel
%NameSAT='Crop1_of_20150815T051150_Orb_Calib_Deb_Sub_Spkle_TC.tif'
NameSAT='Crop2_of_20150815T051150_Orb_Calib_Deb_Sub_Spkle_TC.tif'
%NameSAT='Crop3_of_20150815T051150_Orb_Calib_Deb_Sub_Spkle_TC.tif'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IdData=2
IdDem=3
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% case oil spill Oman
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (0)
PATH_SAT='C:\Users\alberto\Desktop\morea\OilSlick\OMAN'  
NameSAT='subset_0_of_CSKS4_SCS_B_HI_03_HH_RD_SF_20141217135616_20141217135624.tif'
IdData=1
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% case oil spill caspian sea case  sentinel GRD case data

if (0)
PATH_SAT='E:\Proj.OilSpill\CasesOfSutudies\DataProcessing\Output\SAR_Data\S1A\GRD\Caspian_Sea\S1TBX_Output\GeoTIFF\out_SV_20141008T023'

NameSAT='Crop1_of_SV_20141008T023_GRD_TC.tif'
NameSAT='Crop1_of_SV_20141219T023_GRD_TC.tif'
NameSAT='Crop1_of_SV_20141230T143_GRD_TC.tif'
NameSAT='Crop1_of_SV_20150118T142_GRD_TC.tif'

IdData=5
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










%% end dataset
%%-------------------------------------------------------------------------

FLAG_Crop=1;


[Istack Rs]=geotiffread(fullfile(PATH_SAT,NameSAT));


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
[subI Rect]=imcrop;
SUB_LAT=imcrop(LATITUDE,Rect);
SUB_LON=imcrop(LONGITUDE,Rect);
else
subI=Isigma;
SUB_LAT=LATITUDE;
SUB_LON=LONGITUDE;    
end


clear Istack
clear LATITUDE
clear LONGITUDE

figure,imagesc(subI);axis image,colormap gray
caxis([0 nanmean(subI(:))])


%% visualizzazione in coordinate geografiche
figure
figure,geoshow(SUB_LAT,SUB_LON,subI);axis image

%% registra il crop per la riproducibilita
Rcrop=Rect;








