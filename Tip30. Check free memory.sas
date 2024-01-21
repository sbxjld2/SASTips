/* Tip 30. Check free memory available to sas session - used previously with data step hash table 
           format SIZEKMG. format numeric data with suffix K, M or G(igabytes)  */

data _null_;
    xmrlmem = input(getoption('xmrlmem'),20.);
    put " You have " xmrlmem sizekmg8.3 " memory available ";
    mem = input(getoption('memsize'),20.);
    put " You have " mem sizekmg8.3 " memsize ";
run;
