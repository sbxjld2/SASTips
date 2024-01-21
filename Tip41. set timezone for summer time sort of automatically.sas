/* Tip41. How to make sure SAS timezone is set to summer time 
          to set summer time or winter time western europe, submit this code in an autoexec
          SummerTime in BE/NL is between last Sunday of March and last Sunday in October */

%macro setTZ;
     %if  %sysfunc(today()) >= %sysfunc(NWKDOM(5, 1, 3 , %sysfunc(year(%sysfunc(today())))))
      and %sysfunc(today()) le %sysfunc(NWKDOM(5, 1, 10, %sysfunc(year(%sysfunc(today()))))) %then CEST;
     %else CET;
%mend;

options tz="%setTZ";
proc options option=tz; run;

