%Script che calcola la lenght usando la trinagolazione di Delaunay

function [d] = spillLength( img )

%Inizio dello script. Viene passato in input l'immagine s
[x,y]= getVectors(img);
x=x'; % la funzione delaunayTriangolation vuole vettori colonna
y=y';
DT = delaunayTriangulation(x,y);
triplot(DT);
%axis equal
%xlabel('Longitude'), ylabel('Latitude')
%grid on
%hold on
k = convexHull(DT);
xHull = DT.Points(k,1);
yHull = DT.Points(k,2);
%plot(xHull,yHull,'r','LineWidth',2);
%hold off
d=0;
for i=1 : size(xHull)-1 % ciclo che calcola la distanza euclidea tra due punti usando i triangoli più esterni
    
    d= d + sqrt((xHull(i)-xHull(i+1))^2 + (yHull(i)-yHull(i+1))^2);
end
