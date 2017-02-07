function [media, dev] = spillutils( I )

% Questa funzione prende in input una immagine
% e ci calcola media e deviazione standard

[M,N]= size(I); %M n. di righe, N n. di colonne
z=0;
x=0;
for i = 1:M %riga   
    for j = 1:N    %colonna    
        if (I(i,j) ~= 0)
           x=x+ I(i,j); 
           
           z=z+1;
        end
    end
end

media=x/z;

%deviazione standard
x=0;
for i = 1:M %riga   
    for j = 1:N    %colonna    
        if (I(i,j) ~= 0)
           x=x+(I(i,j)- media)^2;
        end
    end
end

dev= sqrt(x/(z-1));
