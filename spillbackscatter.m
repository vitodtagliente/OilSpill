
function [ out ] = spillbackscatter( spill, back )
% Inside Slick Standard Deviation
out.SpillStandardDeviation = mean (std( double( spill ) ) );

% Inside Slick Radar Backcatter
out.SpillMean = mean( mean( spill ) );

% Outside Slick Standard Deviation (?sce)
out.BackStandardDeviation = mean( std( double( back ) ) );

% Outside Slick Radar Backscatter (?sce)
out.BackMean = mean( mean( back ) );

% Intensity Ratio
out.IntensityRatio = out.SpillMean / out.BackMean;

% Intensity Standard Deviation Ratio
out.ISDR = out.SpillStandardDeviation / out.BackStandardDeviation;

% Intensity Standard Deviation Ratio Inside (ISRI)
out.ISRI = out.SpillMean / out.SpillStandardDeviation;

% Intensity Standard Deviation Ratio Outside (ISRO)
out.ISRO = out.BackMean / out.BackStandardDeviation;

% ISRI ISRO Ratio
out.IRatio = out.ISRI / out.ISRO;




% Mean Contrast (ConMe) 
% difference (in dB) between the background mean
% value and the object mean value

out.ConMe = out.BackMean - out.SpillMean;

