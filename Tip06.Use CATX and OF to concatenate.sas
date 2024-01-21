
/* Tip 06 : use CATX to create a string with all variables concatenated 
   Could be used to generate CSV file in certain occasions */

data _null_; 
   length name $ 10;
   set sashelp.class; 
   length newString $1000; 
   newString = catx(",", of _ALL_); 
   putlog newString=; 
run; 
