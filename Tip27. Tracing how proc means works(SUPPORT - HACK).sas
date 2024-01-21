/* Tip27. Hack - Used in some occasion to "look at what proc means/summary is doing */

data large;
do i=1 to 1e3;
 do j=1 to 1e3;
  k=round(ranuni(0)*1E3);
  v=1;
  output;
 end;
end;
%let syssumtrace=5;
proc means data=large tracelevel=9 noprint ;
 class i j k ;
 var v;
 output out=sum sum=;
 run;
proc sql; 
drop table large;
drop table sum;
