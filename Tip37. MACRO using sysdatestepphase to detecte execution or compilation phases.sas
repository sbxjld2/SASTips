/* Step37. use a less know macro to detect datastep phase 
           Placing macro in single or double quote change the phase when that macro is resolved :
           phase=COMPILATION
		   phase=EXECUTION
*/
data _null_;
      x="phase=&sysdatastepphase";
      putlog x;
      call execute('%put phase=&sysdatastepphase;');
run;
