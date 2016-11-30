
%Script che estrae i vettori contenente i punti neri degli assi x e y usato
%per la triangolazione di Delenauy

function [x, y] = getvectors( img )

[M,N]= size(img); %M n. di righe, N n. di colonne
x=zeros(1, M*N); % vettore contenente tutti i valori x delle celle con valore 0, worst case di dimensioni M*N
y=zeros(1, M*N); % vettore contenente tutti i valori y(corrispettive alle x) delle celle con valore 0 

[Length, perim_img] = spillperim( img );
z=1; % N. di elementi dell'immagine che sono 0 ;

% Questo ciclo mi riempie due vettori x e y, contenente le coordinate delle
% "celle" avente il pixel a 1
% I cicli partono da due e termina al valore M -1, poiche in questo modo si
% saltano la prima riga e l'ultima riga, stesso discorso vale per j, si
% salta la prima colonna e l'ultima colonna.
for j = 2:M-1 %riga   
    for i = 2:N-1    %colonna    
        if (perim_img(j,i) == 1)
           x(z)=i; 
           y(z)=j; 
           z=z+1;
        end
    end
end

% Riduzione dei vettori x e y. 
%z contiene la grandezza effettiva delle assegnazioni fatte, quindi 
% dall'elemento z+1 si hanno una serie di 0 non necessari che vengono eliminati.
% ind è il vettore degli indici da eliminare che va da z+1 a M*N (grandezza
% di x e y.
ind = [z+1 : (M*N)];
% eliminazione di tutti i valori non necessari
x(ind)=[];
y(ind)=[];

% ritorno i vettori x e y




