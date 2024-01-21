/* Tip04. more a reminder than a tip : how to set HTML report title */

ods html path ='c:\temp'  path ='c:\temp'  file='class.html' (url=none title='SASHELP KLAS');
title "SASHELP KLAS";
proc print data=sashelp.class;
run;
ods html close;
title;
