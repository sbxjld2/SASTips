/* Tip25. Create a file in a zip container */

filename foo ZIP 'c:\temp\testzip.zip';

%macro doit(mem);
proc sql noprint;
 select strip(name) into :vlist separated by ' '
   from sashelp.vcolumn
  where libname='SASHELP' and memname="%upcase(&mem)"
  order by varnum;
data _null_;
  file foo(&mem..txt) dlm='09'x;
  set sashelp.&mem;
  put &vlist;
run;
%mend;

%doit(cars);
%doit(class);



