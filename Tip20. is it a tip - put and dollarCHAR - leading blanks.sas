
/* Tip20. a small, small problem with PUT X= & using $CHAR. format to have leading blanks 
          when using the form PUTLOG X=, if X variable is formatted with CHARw. 
          (retain leading blanks), the default format ($w.) is used instead, not $CHAR format: no leading blanks appear */
   
*";*';

/* test = if variable is formatted, PUT varname= shows the correctly formatted variable */
data _NULL_;
 x='abcd';        
 numvar=1234.5; 
 format x $hex10. numvar commax9.1;  /* 2 sas formats */
 putlog numvar= '    / OK - correct numeric format used with PUT numvar=';
 putlog x=      '        / OK - $hex var format used in PUT X=  ';
run; 

data _NULL_;
 x='   abcd';         /* variable with leading blanks */
 format x $char10. ;  /* format used to protect leading blanks */
 putlog x=          '        / KO - examine it : no leading blanks in sas log ';
 putlog x $hex14.   ' / hex result shows the blanks are present (x20) ';
 putlog x= $char10. '        / KO - same, no leading blanks in sas log ';
 putlog x           '          / KO - remove the "=" sign ';
 putlog x $char10.  '     / OK : remove the "=" sign and use format ';
 putlog "x=" x $char10.   '   / OK : workaround .. ';
 /* Moral : X= removes leading blanks */
run; 



