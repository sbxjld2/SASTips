/* Tip 01A : real life example */
/* input file has additional characters at the end of record - last variable cannot be read (00x) */

/* generate sample data */
filename data temp;
data _NULL_;
  file data;
  put '1;1111;UN;9001' '00'x;
  put '2;2222;DEUX;9002' '00'x;
  put '3;3333;TROIS;9003' '00'x;
run;

/* last variable is missing, due to x00 character being included */
data test;
 infile data dlm=';';
 input a b c $ d;
run;
ods listing;
title;
proc print data=test;
run;


/* first modify input buffer to remove x00, then process it*/
data test;
 infile data dlm=';';
 input @; 
 _infile_=compress(_infile_,'00'x);
 input a b c $ d;
run;
ods listing;
title;
proc print data=test;
run;
