/* Tip 05 : use different catx functions ... 
   Be careful : catx returns variable of specific length
   if CATx() returned length > receiving variable ==> Missing result */

data names;
  set sashelp.class (obs=8);
  length middle $ 5;
  fname=name;
  lastname=propcase(put(_N_,words12.));
  * CHOOSE A RANDOM LETTER as middle name ;
  if (ranuni(1) ge 0.5) then 
     middle=upcase(substr(name,ceil(ranuni(1)*length(name)),1));
  keep fname lastname middle;
proc print;
run;
             
data final;
  set names;
  fullname=trim(fname)!!" " !!trim(middle)!!" " !! lastname;
  fullname2=catx(' ',fname,middle,lastname);
proc print;
run;
