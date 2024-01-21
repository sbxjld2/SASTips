/* Tip11. datastep COALESCE() function checks the value of each expression in the order in which they are listed /*
/* and returns the first non-null or nonmissing value. */
 
data test;
input a b c @@ ;
cards;
1 . 3 
. . 6 
7 8 9 
. 11 12  
13 . 15
;


data new;
 set test;
 new=coalesce(a,b,c);
run;
proc print;
run;

/* Output
Obs     a     b     c    new

 1      1     .     3      1
 2      .     .     6      6
 3      7     8     9      7
 4      .    11    12     11
 5     13     .    15     13
*/

