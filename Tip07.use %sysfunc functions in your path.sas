/* Tip 07 : get work path to store temporary datasets, outside of work - 
            will be deleted at end of processing 
            may be used to store test file or non sas datasets (ods, etc.) */

%let logpath=%sysfunc(pathname(work));
options nonotes;
%let tempfime=&logpath\myprocess.%sysfunc(date(),YYMMDDN8.)-%sysfunc(time(),z6.).txt;
proc printto log="&tempfile" new;
run;
options notes;
proc print data=sashelp.class;
 
run;
proc printto;
run;

data _NULL_;
 infile "&tempfile";
 input;
 list;
run;
