%Script che calcola la lenght usando la trinagolazione di Delaunay

function [d] = spillLength( img )

%Inizio dello script. Viene passato in input l'immagine s
[x,y]= getVectors(img);
x=x'; % la funzione delaunayTriangolation vuole vettori colonna
y=y';
DT = delaunayTriangulation(x,y);
triplot(DT);
axis equal
xlabel('Longitude'), ylabel('Latitude')
grid on
hold on
k = convexHull(DT);%Contiene l'indice di riga degli elementi del vettore DT.Points che definiscono il contorno.
xHull = DT.Points(k,1);%Crea il vettore di ascisse con i punti del vettore DT.Points
yHull = DT.Points(k,2);
plot(xHull,yHull,'r','LineWidth',2);
hold off
d=0;
for i=1 : size(xHull)-1 % ciclo che calcola la distanza euclidea tra due punti usando la distanza euclidea
    
    d= d + sqrt((xHull(i)-xHull(i+1))^2 + (yHull(i)-yHull(i+1))^2);
end

ti = edgeAttachments(DT,k(1),k(2));
ti{:};%righe della connectivity List contenente il record dei vertici del triangolo
val= DT.ConnectivityList(ti);
val{:};





