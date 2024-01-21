Tip42. How to store users and passwords in code and not display those values in log or to a user */


libname accessT "c:\temp";
options mstored sasmstore=accessT;

/* Next code is submitted once, then saved in a secure location */
%macro accessT / store secure;
  %let notes=%sysfunc(getoption(notes));
  options nonotes;
  libname XXXX ORACLE .... user=<secret> password=<secret>;
  options &notes;
%mend ;

/* user only receives that code to run to access the library without knowing the password */

libname accessT "c:\temp";
options mstored sasmstore=accessT;
options mprint mlogic symbolgen;
%accessT;