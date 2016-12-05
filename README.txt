Con questo Carichi le immagini nella memoria di lavoro di Matlab:

>> start

Oppure 

>> o = spillbegin( 'oil.bmp' );

Caricate le immagini puoi richiamare gli script

>> f = spillfeatures( gspill, gback, s );

Oppure 

>> f = spillfeatures( o.gspill, o.gback, o.s );

##################################

Per eseguire la gestione automatica del dataset

>> spillcsv( 'Dataset', 'output.csv' );