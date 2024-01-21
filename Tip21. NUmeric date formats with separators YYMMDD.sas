/* Tip21. Not really a tip - a reminder about the different date formats and  separators */

data _null_;
  date='31DEC2024'd;
  put date= yymmddB8.;
  put date= yymmddC10.;
  put date= yymmddD10.;
  put date= yymmddN8.;
  put date= yymmddP10.;
  put date= yymmddS10./;

  put date= ddmmyyB8.;
  put date= ddmmyyC10.;
  put date= ddmmyyD10.;
  put date= ddmmyyN8.;
  put date= ddmmyyP10.;
  put date= ddmmyyS10./;

  put date= mmddyyB8.;
  put date= mmddyyC10.;
  put date= mmddyyD10.;
  put date= mmddyyN8.;
  put date= mmddyyP10.;
  put date= mmddyyS10./;

run;
