/* Tip13. random numbers - using hardware RND generator is possibly random'er - windows only ...*/
options msglevel=I;
 
data RandHardware(drop=i);
*   call streaminit('RDRAND');     /* SAS 9.4M3: Hardware method, no seed */
   call streaminit('TRNG');     
   do i = 1 to 5e5;
      uHardware = rand('Uniform'); 
      nHardware = rand('Normal'); 
      output;
   end;
run;
proc univariate;
run;



/*
How to use the new random-number generators in SAS
https://blogs.sas.com/content/iml/2018/01/29/random-number-generators-sas.html
Independence and overlap in streams of random numbers
https://blogs.sas.com/content/iml/2018/05/07/overlap-random-streams.html
Tips and Techniques for Using the Random-Number Generators in SAS®
https://support.sas.com/resources/papers/proceedings18/1810-2018.pdf
CALL STREAMINIT Routine
http://go.documentation.sas.com/?docsetId=lefunctionsref&docsetTarget=p0gw58qo85qp56n1kbpiz50ww8lv.htm&docsetVersion=3.1&locale=en
*/
