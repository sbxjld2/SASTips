
/* Tip 10. used in Support - List all configuration files 30 first lines in 1 step 
           windows only (should add quotes to Linux version) -  
           except if only 1 file in config option */


 *proc options group=languagecontrol value;
 run;

 *proc options internal ;
 run;

%put %sysfunc(getoption(CONFIG));
filename in %sysfunc(getoption(CONFIG));
options ls=120 nocenter;
data _NULL_;
 infile in;
 input;
 list;
 if _N_ gt 30 then stop;
run;

