
function [ isd, osd ] = spillbackscatter( img, back )
% Inside Slick Standard Deviation
isd = std( img );

% Outside Slick Standard Deviation (?sce)
osd = std( back );