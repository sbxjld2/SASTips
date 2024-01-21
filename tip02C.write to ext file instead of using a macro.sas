/*  large macro used to generate data for N years, M months, summarize
 OPTION compress=no SPOOL; /* remove to test */
 
/* Tip02C. %largemacro : generates test data for each day of the month 
   Then  monthly summary + quarterly summary + yearly summary datasets
   */
 proc datasets lib=work kill;

%macro largemacro;

%let seq=1;
 %do y=2024 %to 2025;
   %do m=1 %to 12;
      data data&seq;
          Year=&y;
          Month=&m;
          sdate=mdy(Month,1,Year);  /* mdyymd() function */

          format date date9.;
          do date=sdate to intnx('MONTH',sdate,1)-1;
             value=rand('UNIFORM')*1000+1000;
             output;
          end;
          drop sdate;
      run;
      proc summary data=data&seq nway;
       var value;
       class year month;
       output out=Msummary_&y._&m(drop=_FREQ_ _TYPE_) sum=;
      run;
      %if &m =3 OR &m=6 OR &m=9 OR &m=12 %then %do;
       %let q=%sysevalf(1+%sysfunc(mod(&m,3)));
       proc sql;
       create table Qsummary_&y._Q&Q.
        as select sum(value) as value format=commax12.2 from (
        select * from Msummary_&y._&m
         union all corr 
           select * from Msummary_&y._%sysevalf(&m-1)
         union all corr 
           select * from Msummary_&y._%sysevalf(&m-2));
        quit;
      %end;
      %if &m=12 %then %do;
       proc sql;
       create table Ysummary_&y.
        as select sum(value) as value format=commax12.2    from (
       %let finseq=%sysevalf(&seq-11);    
       %do s=&finseq %to &seq;
          select * from data&s
         %if &s ne &seq %then union all corr ;
       %end;
        );quit;
      %end;
    
    %let seq=%sysevalf(&seq+1);
    %end;
%end;
%mend;
options nomprint nosymbolgen nomlogic;
%largemacro;

/* or create a macro that generates data + monthly summary, 
   then parameterize to do QTR and YRLY summaries */

/* to do */
%macro CreateOne(seq,m,y,qtrsum=N,YearSum=N);
      data data&seq;
          Year=&y;
          Month=&m;
          _sdate=mdy(Month,1,Year);  
          do date=_sdate to intnx('MONTH',sdate,1)-1;
             value=rand('UNIFORM')*1000+1000;
             output;
          end;
          format date date9.;
          drop _sdate;
      run;
      proc summary data=data&seq nway;
       var value;
       class year ;
       output out=Ysummary_&y.(drop=_FREQ_ _TYPE_) sum=;
      run; 
  
%mend;
