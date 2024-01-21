/* Tip19. using USER= option to change the location of one level names datasets  */
                    
data test; /* created in WORK by default */
 set sashelp.class;
run;

options dlcreatedir;
libname NEWwork  "%sysfunc(pathname(work))\NewWork";
options USER=NEWWORK;

data test; /* now created in NEWWORK library */
 set sashelp.cars;
run;

title "both libraries ";
proc contents data=test;
proc contents data=NEWwork.test;
proc contents data=work.test;
run;
/* next one should fail, because work.somedata still uses the real WORK */
proc contents data=work.test;
run;

options USER=WORK;
