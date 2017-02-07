
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
%stampa la prima riga con le etichette del file csv
fprintf(file, sprintf('%s', 'Name'));
fprintf(file, sprintf(',%s', 'Perimeter'));
fprintf(file, sprintf(',%s', 'Area'));
fprintf(file, sprintf(',%s', 'Complexity'));
fprintf(file, sprintf(',%s', 'Length'));
fprintf(file, sprintf(',%s', 'Width'));
fprintf(file, sprintf(',%s', 'LWR'));
fprintf(file, sprintf(',%s', 'Comp'));
fprintf(file, sprintf(',%s', 'FIPM'));
fprintf(file, sprintf(',%s', 'EL'));
fprintf(file, sprintf(',%s', 'EW'));
fprintf(file, sprintf(',%s', 'EA'));
fprintf(file, sprintf(',%s', 'SpillSTD'));
fprintf(file, sprintf(',%s', 'SpillMean'));
fprintf(file, sprintf(',%s', 'BackgroundSTD'));
fprintf(file, sprintf(',%s', 'BackgroundMean'));
fprintf(file, sprintf(',%s', 'IntensityRatio'));
fprintf(file, sprintf(',%s', 'ISDR'));
fprintf(file, sprintf(',%s', 'ISRI'));
fprintf(file, sprintf(',%s', 'ISRO'));
fprintf(file, sprintf(',%s', 'IRatio'));
fprintf(file, sprintf(',%s', 'ConMe'));
fprintf(file, sprintf(',%s', 'GMax'));
fprintf(file, sprintf(',%s', 'GMe'));
fprintf(file, sprintf(',%s', 'GSd'));
fprintf(file, sprintf(',%s', 'Homogeneity'));
fprintf(file, sprintf(',%s', 'Contrast'));
fprintf(file, sprintf(',%s', 'Entropy'));
fprintf(file, sprintf(',%s', 'Correlation'));
fprintf(file, sprintf(',%s', 'Dissimilarity'));
fprintf(file, sprintf(',%s', 'spotsCount'));
fprintf(file, sprintf(',%s', 'nextSpotDistance'));
fprintf(file, sprintf(',%s', 'minDistFromLand\n'));
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
        c = f.Context;
        
        % Scrivi il nome del file
        fprintf(file, sprintf('%s', files(i).name));
        % Features Geometriche
        if ~isnan(g.Perimeter)
            fprintf(file, sprintf(',%f', g.Perimeter));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.Area)
            fprintf(file, sprintf(',%f', g.Area));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.Complexity)
            fprintf(file, sprintf(',%f', g.Complexity));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.Length)
        fprintf(file, sprintf(',%f', g.Length));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.Width)
        fprintf(file, sprintf(',%f', g.Width));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.LWR)
        fprintf(file, sprintf(',%f', g.LWR));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.Comp)
        fprintf(file, sprintf(',%f', g.Comp));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.FIPM)
        fprintf(file, sprintf(',%f', g.FIPM));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.EL)
        fprintf(file, sprintf(',%f', g.EL));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.EW)
        fprintf(file, sprintf(',%f', g.EW));
         else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(g.EA)
        fprintf(file, sprintf(',%f', g.EA));
         else
           fprintf(file, sprintf(',')); 
        end
        % Backscatter
        if ~isnan(b.SpillStandardDeviation)
        fprintf(file, sprintf(',%f', b.SpillStandardDeviation));
         else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.SpillMean)
        fprintf(file, sprintf(',%f', b.SpillMean));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.BackStandardDeviation)
        fprintf(file, sprintf(',%f', b.BackStandardDeviation));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.BackMean)
        fprintf(file, sprintf(',%f', b.BackMean));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.IntensityRatio)
        fprintf(file, sprintf(',%f', b.IntensityRatio));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.ISDR)
        fprintf(file, sprintf(',%f', b.ISDR));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.ISRI)
        fprintf(file, sprintf(',%f', b.ISRI));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.ISRO)
        fprintf(file, sprintf(',%f', b.ISRO));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.IRatio)
        fprintf(file, sprintf(',%f', b.IRatio));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.ConMe)
        fprintf(file, sprintf(',%f', b.ConMe));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.GMax)
        fprintf(file, sprintf(',%f', b.GMax));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.GMe)
        fprintf(file, sprintf(',%f', b.GMe)); 
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(b.GSd)
        fprintf(file, sprintf(',%f', b.GSd)); 
        else
           fprintf(file, sprintf(',')); 
        end
        % Texture
        if ~isnan(t.Homogeneity)
        fprintf(file, sprintf(',%f', t.Homogeneity));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(t.Contrast)
        fprintf(file, sprintf(',%f', t.Contrast)); 
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(t.Entropy)
        fprintf(file, sprintf(',%f', t.Entropy)); 
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(t.Correlation)
        fprintf(file, sprintf(',%f', t.Correlation)); 
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(t.Dissimilarity)
        fprintf(file, sprintf(',%f', t.Dissimilarity)); 
        else
           fprintf(file, sprintf(',')); 
        end
        % Ancillari
        if ~isnan(c.spotsCount)
        fprintf(file, sprintf(',%f', c.spotsCount));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(c.nextSpotDistance)
        fprintf(file, sprintf(',%f', c.nextSpotDistance));
        else
           fprintf(file, sprintf(',')); 
        end
        if ~isnan(c.minDistFromLand)
        fprintf(file, sprintf(',%f', c.minDistFromLand));
        else
           fprintf(file, sprintf(',')); 
        end
        % Vai a capo
        fprintf(file, '\n');      
    end
end

% Chiudi il file
fclose( file );
% Stoppiamo il timer
toc
