Tip29. When code is used in stored process, used through a browser, 
avoid any issue like the following SQL injection by using symget() function 
*/

/* values below are supposed to be entered in a prompt */
%let value=Alice;
proc print data=sashelp.class;
 where name="&value";
run; /* OK */

%let value=Alfred;
proc print data=sashelp.class;
 where name="&value";
run; /* OK */

data _NULL_;
 call symput(cats('VALUE'),'";endsas;');
run;
proc print data=sashelp.class;
 where name="&value";
run; /* does not do what you expect - sql injection */
/* ";proc datasets lib=XXXX kill; would possibly do more harm */

/*Solution : use symget() function */

proc print data=sashelp.class;
where name=symget('VALUE');
run;
