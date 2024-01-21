/* Tip12. Compute last day of month - use SAS date functions */

data datetest;
  do date=intnx('YEAR',today(),-1) to today() by 17;
    output;
  end;
  date='29feb2024'd; /* Leap year test */ output;
  format date ddmmYY10.;
run;

data new;
 set datetest;
 StartofPrevYear=intnx('YEAR',date,-1);
 NextYear=intnx('YEAR',date,1,'SAME');
 StartofWeek=intnx('WEEK',date,0);
 LastDayofPrevMonth=intnx('MONTH',date,0)-1;
 format startofprevyear nextyear weekdatx. date startofweek lastDayofPrevMonth weekdatx.;
run;
proc print data=new (obs=50);
run;



