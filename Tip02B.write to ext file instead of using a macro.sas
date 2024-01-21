/* Tip02B. writing to external file to run some macro code 
   Instead of the big large macro (%mylargemacro) used before  
   that are difficult to debug, difficult to test, where generated code 
   runs at the same time the macro code is running
   Example starts with old macro style with loops to store data 
   Second section shows the same using a one operation macro (%doit) 
   and a datastep that generates the macro call  */
 
%macro mylargemacro(start, end);
  data _NULL_;
   set sashelp.class nobs=nobs end=end;
   call symput('name'!!left(put(_N_,2.)),strip(name));
   call symput('age'!!left(put(_N_,2.)),age);
   if end then call symput('NOBS',nobs);
  run;
  %put _all_;

  %do i=1 %to &nobs;
     proc summary data=sashelp.class ;
    var height;
    where name="&name&&i" and age ="&&age&i";
    output out=sum&i sum=;
     run;
  /* etc. */
  %end;

%mend;
%mylargemacro;

 

/* NEW STYLE CODE - the macro code processes only 1 item - no loop code here */
%Macro doIt(name,loop);
  proc summary data=sashelp.class ;
    var height;
    where name="&name";
    output out=sum&loop._&name sum=;
  run;
%mend;

/* testing doit macro for one record*/
%doit(Alice,99);

/* loops are written in a datastep and code written to temp file */
filename code temp;
data _null_;
 set sashelp.class;
 file code;
 put '%doIt(name=' name ',loop=' _N_ ');';
run;

%inc code / source2;

