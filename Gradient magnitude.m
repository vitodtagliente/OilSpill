
I=imread('s.bmp');
%Calculate x and y directional gradients and then gradient magnitude and direction.
[Gx, Gy] = imgradientxy(I);
[Gmag, Gdir] = imgradient(Gx, Gy);
figure; imshowpair(Gmag, Gdir, 'montage'); axis off;
title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Sobel method')
figure; imshowpair(Gx, Gy, 'montage'); axis off;
title('Directional Gradients, Gx and Gy, using Sobel method');


%Questo script calcola il gradient magnitude e la direzione, usando sobel
% ma lo da sotto forma di immagine, a noi serve quantificare i valori
% e prendere il massimo, la media e la deviazione standard
%che sono i parametri richiesti....

%https://it.mathworks.com/help/images/ref/imgradientxy.html