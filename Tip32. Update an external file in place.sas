/* Tip32. use sharebuffers option to read and write from/to the same external file */

filename extdata "!temp\fox.txt";
data _null_;
  file "!temp\fox.txt";
  put 'a  quickbrownfox' /
      'b  quickbrownfox' /
      'c  quickbrownfox' /
      'd  quickbrownfox' /
      'a  quickbrownfox' /
      'a  quickbrownfox' ;
run;

/* Data set of changes to be made */

data _null_;
  /* sharebufffers : key to update in place */
  infile extdata truncover sharebuffers;
  file  extdata ;
  input @1 id $1. ; 
  if id=:'a' then put _infile_ @9 'green';
  else if id=:'d' then put _infile_ @9 'white';
run;

data _null_;
  infile  extdata  ;
  input;
  list;
  run;
