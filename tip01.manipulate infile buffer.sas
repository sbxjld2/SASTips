
/* Tip01 : Manipulate infile buffer to change separator */


/* example - does not work -  datetime value from log has a comma separator, invalid with this specific informat  */
data log;
 infile cards dlm=';' ;
 input dt datetime26.3 ;
 format dt datetime26.3;
 putlog _all_;
cards4;
31dec2018:23:59:59,123
31dec2022:23:59:59.123
;;;;



/* Tip01 : Manipulate infile buffer to change datetime hundredth of seconds separator */
data log;
 infile cards dlm=';' ;

 input @;
 pos=index(_infile_,',');
 if pos le 30 then substr(_infile_,pos,1)='.';

 input dt datetime26.3 ;
 format dt datetime26.3;
 putlog _all_;
cards4;
31dec2018:23:59:59,123
31dec2018:23:59:59.123
;;;;


/* Tip01 : Manipulate infile buffer to change some separators : from "$$" to ";" */
data xx;
 infile cards dlm=';' ;
 length a1-a5 8;
 input@;
 put _infile_;
 _infile_=tranwrd(_infile_,'$$',';');
 informat a5 dollar.;
 input a1-a5  ;
 put _infile_;
cards4;
1111$$2222$$33333;4444;5555
;;;;


/* Tip01 : Manipulate infile buffer to change values - here FF = negative number */
data xx;
 infile cards dlm=';' ;
 length a1-a5 8;
 input@;
 put _infile_;
 _infile_=tranwrd(_infile_,'FF','-');
 informat a5 dollar.;
 input a1-a5  ;
 put _all_;
cards4;
FF1111;2222;33333;4444;FF5555
;;;;
