/* Tip 02. generate code to insert data into DBMS
   in real life, additional DBMS-specific options were were used with each INSERT */

options sastrace=',,,d' sastraceloc=saslog nostsuffix;

%let opts=%str(database=test server=localhost user=&user password=&pw);
libname postg postgres &opts;

data toinsert;
input name : $12. sex : $1. age ;
cards;
Adele F 22
Barbara F 23
Christian M 20
;
run;

filename code temp;
data NULL_;
 set toinsert ;
 file code lrecl=1024;
 length line $1024;
 
 line=catt("insert into class (name,sex,age) values(",quote(trim(name),"'") ,',' ,quote(sex,"'") ,"," ,age ,")" );
 line=catt('EXECUTE(',strip(line),') BY postgres;');
 put line;
 putlog line;
run;

options mprint;
options source source2;
proc sql; 
 connect to postgres(&opts);
 %inc code;
 quit;
