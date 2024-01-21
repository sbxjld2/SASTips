/* Tip 08. use proc sql and dictionnary table to generate code 
           expand all character variables by 10% 
           Only works if macro variable length < 65K */

%let mem=CARS;
proc sql noprint;
 select catt('length ',' '!!name,  ' $',put(ceil(length*1.1),4.)) 
   into :lenstmt separated by ';'
   from sashelp.vcolumn
   where libname="SASHELP" and memname="&mem" and type='char'
   order by varnum;
%put %bquote(&lenstmt);

data &mem;
 &lenstmt;
 set sashelp.&mem;
proc contents data=&mem;
run;


/* reorder variables in alphabetic order */
%let mem=CARS;
proc sql noprint;
 select catt('length ',' '!!name,  case type when 'char' then ' $' else ' ' end,put(length,4.)) 
   into :lenstmt separated by ';'
   from sashelp.vcolumn
   where libname="SASHELP" and memname="&mem" 
   order by name;
%put %bquote(&lenstmt);

data &mem;
 &lenstmt;
 set sashelp.&mem;
proc contents data=&mem varnum;
run;
