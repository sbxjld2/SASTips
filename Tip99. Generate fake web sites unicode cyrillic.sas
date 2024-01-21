/* Tip99. It's not a tip - just to generate cyrillic characters for testing 
          unicode characters that look very similar to standard ascii alphabet */

data test;
 input b  $1. +1 a  $hex4.;
 xa=a;
 xb=b;
 format x: $hex4.; 
 urla=klowcase('http://www.s'!!a!!'s.com');
 urlb=klowcase('http://www.s'!!b!!'s.com');
 httpa='<DIV><A href="'!!urla!!'">'!!urla!!'</A>';
 httpb='<DIV><A href="'!!urlb!!'">'!!urlb!!'</A>';
cards4;
a d090
p d180
c d181
e d0b5
o d0be
s d195
;;;;

ods listing close;
ods html;
proc print;
 var http: x:  ;
run;

