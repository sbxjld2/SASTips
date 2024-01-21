/*Tip39. Want to know what variables/datasets/files this datastep is creating/using ?
         use PROC SCAPROC */
         
     
/* start gathering data - timestmap + variables-related information */
proc scaproc; 
   record '!temp/record.txt' attr OPENTIMES; 
run;
/* run test code */
data a(keep=i index=(i)) b(keep=i j k) ; 
   do i = 1 to 1e7; 
      j = round(i,1e6); 
      k=sin(i);
      if mod(i,2)=0 then output a;
      else output b;
   end; 
run;

ods output  Univariate.j.BasicMeasures=BasicMeasures;
proc univariate data=b;
var j;
run;
ods output close;

proc summary data=b;
class j;
var k;
output out=summary sum=;
run;

proc sql;
create table c as select * from a where i < 100;

proc means data=a;
run;
/* terminate scaproc logging */
proc scaproc; 
   write; 
run;

/* examine what has been generated */
data _NULL_;
 infile    '!temp/record.txt'; 
 input;
 put _infile_;
run;
