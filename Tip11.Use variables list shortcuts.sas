/* Tip11. using SAS variables "shortcuts" to concatenate variables in sas syntax 
          complete list : 
   https://blogs.sas.com/content/iml/2018/05/29/6-easy-ways-to-specify-a-list-of-variables-in-sas.html
*/


data sales;
 length key 8 vv1 vv2 8 emptyvar $7 X 8 vv3-vv12 7;
 x=100000;
 do key=1 to 10;
  array vv(12) 8;
  do _N_=1 to dim(vv);
    vv(_N_)=key*19+_N_;
  end;
  output;
 end;
run;

title 'vv1-vv3';
proc print data=sales;
 var vv1-vv3;
run;

title 'key--vv4';
proc print data=sales;
 var key--vv4;
run;



data total;
 set sales;
 total=sum(OF vv1--vv5); /* all variables in PDV between those 2 vars - contains X */
 total2=sum(vv1-vv5); /* variable VV5 - VV1 !!! */
 total3=sum(of vv:);  /* sum all variables (names) starting with V */
 total4=sum(OF vv1-vv5); /* sum variables VV1 to VV5 */
proc print data=total;
run;
title;

/* quote all character variables in 1 run */
data allchars;
  set sashelp.cars;
  array cc(*) _character_;
  do _N_=1 to dim(cc);
     cc(_N_)=quote(strip(cc(_N_)));
  end;
run;
