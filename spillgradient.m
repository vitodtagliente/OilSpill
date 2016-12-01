%Questa funzione prende in input una immagine binarizzata o grayscale e ne
%calcola il gradiente lungo gli assi x e y (Gx e Gy) e poi calcola il G
%magnitude e la direzione, individuandone il Massimo, la media e la dev
%standard restiduendo i valori in dB.
%Io ho passato sempre una immagine binarizzata, ma le funzioni imgradient e
%imgradient xy, funzionano anche con una grayscale(da quanto dice la
%documentazione di matlab)



function [ gMax, gMe, gSt] = spillgradient(I)



%Calcolo il gradiente lungo le due direzioni
%[Gx, Gy] = imgradientxy(I);
%calcolo il G Magnitude e la direzione usando sobel (default, Gx e Gy,
%vengono calcolati dentro imgradient se non presenti...
[Gmag, Gdir] = imgradient(I, 'sobel');
%individuo il valore massimo
[Max,k]=max(max(Gmag));

% effettua la media dei valori del perimetro(esclude i valori che sono 0
% nel background dell'immagine! I cicli non tengono conto del

[M,N]= size(I); %M n. di righe, N n. di colonne
z=0;
x=0;
for i = 1:M %riga   
    for j = 1:N    %colonna    
        if (Gmag(i,j) ~= 0)
           x=x+ Gmag(i,j); 
           
           z=z+1;
        end
    end
end

media=x/z;

%deviazione standard
x=0;
for i = 1:M %riga   
    for j = 1:N    %colonna    
        if (Gmag(i,j) ~= 0)
           x=x+(Gmag(i,j)- media)^2;
        end
    end
end

dev= sqrt(x/(z-1));




%trasformazione in db dei valori trovati
gMax = mag2db(Max);
gMe= mag2db(media);
gSt= mag2db(dev);