
/* Tip15. I do not use those  date function a lot ...*/

title "List every Monday in Feb2019";
data _NULL_;
  do i=1 to 5;
    d=NWKDOM(i, 2, 2,2019);
    format d weekdatx.;
    put i= d=;
  end;
run;

title "List every last Sunday of the month in 2019";
data _NULL_;
  do m=1 to 12;
    d=NWKDOM(5, 1, m,2019);
    format d weekdatx.;
    put m= d=;
  end;
run;

title "List every first Thursday of the month in 2021";
data _NULL_;
  do m=1 to 12;
    d=NWKDOM(1, 5, m,2021);
    format d weekdatx.;
    put m= d=;
  end;
run;

title "List first Thursday of current month";
data _NULL_;
    d=NWKDOM(1, 5, month(today()),year(today()));
    format d weekdatx.;
    put d=;
run;
title;
