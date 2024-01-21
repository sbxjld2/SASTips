/* Tip 03 : check memory settings and create a huge hash table */
/*          to check if SAS session is capable of storing it */
/* use several hash tables fucntions to evalute size */

proc options GROUP=MEMORY value;
run;

/* xmrlmem option : how much ram is left to SAS session 
   memsize : max memory SAS will use, if available */
%put NOTE: xmrlmem = %sysfunc(getoption(xmrlmem),commax20.);
%put NOTE: memsize = %sysfunc(getoption(memsize),commax20.);
* SASPedia : XMRLMEM - TKStatus   tkmrlmem(// Returns an educated guess for the amount of mremnt of memory
                    // that can be allocated without causing problems.;


%let maxh=3*1024**2; /* = &maxh GB */
options fullstimer;

data _null_;
  length key  8 value $ 980;
  dcl hash h();
  h.defineKey('key');
  h.defineData('value');
  h.defineDone();
  do key = 1 to &maxh;
    value=repeat(put(key,words100.),20);
    h.add();
  end;
  sz=h.item_size;
  numitems=h.num_items;
  xmrlmem = input(getoption('xmrlmem'),best.);
  putlog 'each item size=' sz ' - num items=' numitems '- Remaining memory : ' xmrlmem sizekmg20.; 
run;
