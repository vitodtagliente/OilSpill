
function [ out ] = spillbackscatter( spill, back )
% Inside Slick Standard Deviation
out.isd = mean (std( double( spill ) ) );

% Inside Slick Radar Backcatter
out.imd = mean( mean( spill ) );

% Outside Slick Standard Deviation (?sce)
out.osd = mean( std( double( back ) ) );

% Outside Slick Radar Backscatter (?sce)
out.omd = mean( mean( back ) );

% Intensity Ratio
out.ir = out.imd / out.omd;

% Intensity Standard Deviation Ratio
out.isdr = out.isd / out.osd;

% Intensity Standard Deviation Ratio Inside (ISRI)
out.isri = out.imd / out.isd;

% Intensity Standard Deviation Ratio Outside (ISRO)
out.isro = out.omd / out.osd;

% ISRI ISRO Ratio
out.iratio = out.isri / out.isro;




% Mean Contrast (ConMe) 
% difference (in dB) between the background mean
% value and the object mean value

out.conme = out.omd - out.imd;

