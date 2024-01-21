/* Tip 38. Detect a zero obs. situation from inside the data step  to stop it or terminate the batch session */

* first let's generate an empty dataset;
data a;
 x=1;
 stop;
run;

/* placing the nobs test after SET : IF will never be reached because no obs. in dataset */
data b;
   set a nobs=nobs;
   if nobs=0 then putlog 'would never be written to log'; 
run;

/* IF before SET to set a macro value (or abort in batch) */
data b;
 if nobs=0 then do; put 'WARNING: ending process: zero obs.'; call symput('nothingtodo',1); end;
/*OR*/ 
 if not missing(getoption('sysin')) and nobs=0 then do; put 'WARNING: ending batch process: zero obs.'; abort return 0; end;
 set a nobs=nobs;
run;
