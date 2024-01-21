/* Tip35. register truetype font Arial in SAS, to be used in SAS Graph */

proc fontreg mode=all msglevel=verbose usesashelp;
   fontfile 'C:\Windows\Fonts\arial.ttf';
run;


/* register all truetype fonts found in windows\Fonts directory */
PROC FONTREG; run;

/*
https://blogs.sas.com/content/sgf/2020/03/20/how-to-debug-5-common-sas-software-font-issues/
*/
