
/* Tip 15. just a useless trick - useful if bits arithmetic is needed */

/* exchange 2 variables without using a 3rd temporary variable */
/* only works for natural numbers (0-9.9E99) */
/* no negative, nor rational, nor decimal numbers */

data _NULL_;
 x=123456789;
 y=2;
 put x= hex16. y= hex16. ;
 x=bxor(x,y);
 put x= hex16. y= hex16. ;
 y=bxor(x,y);
 put x= hex16. y= hex16. ;
 x=bxor(x,y);
 put x= hex16. y= hex16. ;
 put x= z10. y= z10. ;
run;
