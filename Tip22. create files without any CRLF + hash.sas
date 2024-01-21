/* Tip 22 : create file that contain only data = no line break
   RECFM=N : binary format. The file consists of a stream of bytes with no record boundaries.
   Code shows that both file, using a different record length have the same binary content */
/* + additional tip = use hashing_file() to uniquely identify a file */

filename A "%sysfunc(pathname(work))\A.bin";
filename B "%sysfunc(pathname(work))\B.bin";

data _NULL_;
 do i=1 to 1E6;
  file A recfm=n lrecl=256;
  put i z13. @@; 
  file B recfm=n lrecl=100000;
  put i z13. @@;
 end;
run;

/* check both files are identical */
/* Windows command : certutil  -hashfile A.bin sha256" */
data _NULL_; 
 A = hashing_file('sha256',pathname('A'));    
 B = hashing_file('sha256',pathname('B'));    
 putlog A / B;
run;
