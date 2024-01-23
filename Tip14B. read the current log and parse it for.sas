/* Tip14B. In some cases, SAS does not detect properly some errors (I could not reproduce)
          At the end of the job, it is possible to scan the current job log, and parse it
          for any problem you want to detect, instead of submitting a second job to scan the first job log */

%let email=jean.louis.dubois@sas.com;

/* generate some error - here : user and pw are missing */
filename outods ftp "/test/class.%sysfunc(time(),z5.).pdf" host =localhost user="&user" password="&pw" ;
ods pdf file=outods notoc;
proc print data=sashelp.class;
run;
ods pdf close;
filename outods clear;


/* start of termination section - could be enclosed 
   in a macro and added in option -TERMSTMT, in config file */
%macro sendlog;
 %put ******* "%sysfunc(pathname(logcopy))"  ;
 Data _NULL_;
  infile "%sysfunc(getoption(LOG))" share;
  file logcopy ;
  input;
  put _infile_;
 run;

 filename o email subject='Job in error' 
   to="&email" from="&email" sender="&email"
   attach="%sysfunc(pathname(logcopy))"   ;
 data _NULL_;
   file o;
   put= "Job " !! getoption('sysin') !!' is in error' 
       !! put(datetime(),datetime.);
   put put;
 run;
%mend;

filename logcopy temp;
option nomprint obs=max replace nosyntaxcheck;
Data _NULL_;
 infile "%sysfunc(getoption(LOG))" share;
 input;
 if _infile_=:'ERROR:' then do; 
   call execute('%sendlog');
   abort;
 end;
run;


