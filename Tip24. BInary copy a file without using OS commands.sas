/* Copy external file not using operating system command - when noxcmd is set */
/* More robust binaryfilecopy macro : https://blogs.sas.com/content/sasdummy/files/2013/09/binaryfilecopy.sas_.txt */

%macro copybin(inpath=,outpath=,file=);
  %PUT NOTE: BINARY COPY FROM &inpath\&file TO &outpath;
  data _NULL_;
   infile "&inpath\&file" recfm=N  ;
   file "&outpath\&file" recfm=N;
   input c $char1. @@;
   N+1;  call symput('N',put(n,sizekmg.));
   put c $char1.  @@;
  run;
  %put WARNING: &n copied;
%mend;

* generate random data ;
data _NULL_;
 file "random.dat" dlm=';';
 call streaminit('TRNG');     
 do i=1 to 1e6;
      ran = round(rand('Uniform')*1e15); 
      put i ran;
   end;
run;
                                             *';*";

%copybin(inpath=.,file=random.dat,outpath=c:\temp);

data _NULL_; 
 A = hashing_file('sha256','random.dat');    
 B = hashing_file('sha256','\temp\random.dat');    
 putlog A / B;
run;

