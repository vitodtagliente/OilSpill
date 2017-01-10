
% Il seguente script presenta i parametri
% dataset: path della directory delle immagini
% filename: nome del file csv di output

function [] = spillcsv( dataset, csvname )
% Teniamo traccia del tempo di esecuzione
tic;
% Ottieni la lista dei file presenti nella directory
files = dir( dataset );

% Apri il file di scrittura
file = fopen(csvname, 'w');

% Estrai le features di ogni immagine
% ed aggiungile al csv
s = size(files);
for i=1:s(1)
    if strcmp(files(i).name, '.') == 0 && strcmp(files(i).name, '..') == 0
        o = spilltif( sprintf('%s/%s', dataset, files(i).name) );
        f = spillfeatures(o);
        
        % Scrivi le features su csv
        g = f.Geometrical;
        b = f.Backscatter;
        t = f.Texture;
        
        % Scrivi il nome del file
        fprintf(file, sprintf('%s', files(i).name));
        % Features Geometriche
        fprintf(file, sprintf(',%s', g.Perimeter));
        fprintf(file, sprintf(',%s', g.Area));
        fprintf(file, sprintf(',%s', g.Complexity));
        fprintf(file, sprintf(',%s', g.Length));
        fprintf(file, sprintf(',%s', g.FIPM));
        fprintf(file, sprintf(',%s', g.EL));
        fprintf(file, sprintf(',%s', g.EW));
        fprintf(file, sprintf(',%s', g.EA));
        % Backscatter
        fprintf(file, sprintf(',%s', b.SpillStandardDeviation)); 
        fprintf(file, sprintf(',%s', b.SpillMean));
        fprintf(file, sprintf(',%s', b.BackStandardDeviation));
        fprintf(file, sprintf(',%s', b.BackMean));
        fprintf(file, sprintf(',%s', b.IntensityRatio));
        fprintf(file, sprintf(',%s', b.ISDR));
        fprintf(file, sprintf(',%s', b.ISRI));
        fprintf(file, sprintf(',%s', b.ISRO));
        fprintf(file, sprintf(',%s', b.IRatio));
        fprintf(file, sprintf(',%s', b.ConMe));
        fprintf(file, sprintf(',%s', b.GMax)); 
        fprintf(file, sprintf(',%s', b.GMe)); 
        fprintf(file, sprintf(',%s', b.GSd));       
        % Texture        
        fprintf(file, sprintf(',%s', t.Homogeneity));
        fprintf(file, sprintf(',%s', t.Contrast)); 
        fprintf(file, sprintf(',%s', t.Entropy)); 
        fprintf(file, sprintf(',%s', t.Correlation)); 
        fprintf(file, sprintf(',%s', t.Dissimilarity)); 
        % Vai a capo
        fprintf(file, '\n');      
    end
end

% Chiudi il file
fclose( file );
% Stoppiamo il timer
toc
