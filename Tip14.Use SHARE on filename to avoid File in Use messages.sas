/*
Tip 14. Use SHARE option to prevent error message
ERROR: File is in use, C:\Users\?????\AppData\Local\Temp\Microsoft\Teams\meeting-addin\teams-meeting-addin.log.
*/

filename in "!localappdata\Temp\Microsoft\Teams\meeting-addin\teams-meeting-addin.log" share;
data log;
   infile in truncover ;
   input ?? _d  YYMMDD10. +1 ?? _t ?? time12.3 @;
   if missing(_d) and missing(_t)
     then input @1 text $2000.;
     else do;
       input id  $ sev $ cmpnent : $100. text $2000. ;
       date=_d;
       time=_t;
     end;
   retain date time;
   format date date. time time.;
   drop _: ;
 run;
 proc print data=log (obs=10);
 proc print data=log (firstobs=1360 obs=1380);
 run;
 proc print data=log ;
    where sev='Warn' and text=:'Raise';
 run;
 proc sql;
    select sev,count(*) from log group by 1;
 quit;
