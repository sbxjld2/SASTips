/* Tip33. when xcmd is not available, it is not possible to use DIR or ls commands 
          to list files in a directory 
          infile allows to read files without using an externl command 
          This example reads all log files located in \temp */
      
filename dir "\temp";
data logs2;
 length _fn fn $ 100;
 infile dir('*.log') filename=_fn truncover;
 input line $250. ;
 fn=_fn;
 date=input(scan(fn,-5,'.'),?? YYMMDD10.);
 if date> today()-3;
 format date date.;
run;
proc print data=logs2;
run;
