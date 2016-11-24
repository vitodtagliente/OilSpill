
function [ isd, osd ] = spillbackscatter( spill, back )
% Inside Slick Standard Deviation
isd = std( double( spill ) );
[a b] = size( isd );
isd = sum( isd ) / b;

% Outside Slick Standard Deviation (?sce)
osd = std( double( back ) );
[a b] = size( osd );
osd = sum( osd ) / b;
