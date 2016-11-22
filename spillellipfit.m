
% Script per il fitting di una ellisse
% length: value of main axe of an ellipse fitted to the data.
% width: value of minor axe of an ellipse fitted to the data.

function [majoraxis, minaxis] = spillellipfit( img, debug )
% il parametro debug è opzionale
if nargin <= 1
   debug = false; 
end

props = regionprops(img, 'Orientation', 'MajorAxisLength', ...
    'MinorAxisLength', 'Eccentricity', 'Centroid');

% Rappresentazioni grafiche delle ellissi
if debug
    imshow( img );
    hold on;

    phi = linspace(0,2*pi,50);
    cosphi = cos(phi);
    sinphi = sin(phi);

    for k = 1:length(props)
        xbar = props(k).Centroid(1);
        ybar = props(k).Centroid(2);

        a = props(k).MajorAxisLength/2;
        b = props(k).MinorAxisLength/2;

        theta = pi*props(k).Orientation/180;
        R = [ cos(theta)   sin(theta)
             -sin(theta)   cos(theta)];

        xy = [a*cosphi; b*sinphi];
        xy = R*xy;

        x = xy(1,:) + xbar;
        y = xy(2,:) + ybar;

        plot(x,y,'r','LineWidth',2);
    end
    hold off  
end

majoraxis = props(1).MajorAxisLength;
minaxis = props(1).MinorAxisLength;
for k = 2:length(props)
    if props(k).MajorAxisLength > majoraxis
       majoraxis = props(k).MajorAxisLength; 
    end
    if props(k).MinorAxisLength < minaxis
       minaxis = props(k).MinorAxisLength; 
    end
end
