 /* Tip23. hashfile() function, and my own hash, when hashfile did not exist */

%let fn=!TEMP\sample.asc;
data _NULL_;
 set sashelp.cars;
 file "&fn";
 put _all_  ;
run; 
data _NULL_;
   hash = hashing_file('sha256',"&fn");
   putlog hash=;
   run;



data xxx;
 infile "&fn" lrecl=1 recfm=N;
 input c $1. ;
 format c $hex2.;
 v=input(c,s370FPIB1.);
 sum+(v+1*_n_);
 call symput('myhash',sum);
run;
%put &myhash;
