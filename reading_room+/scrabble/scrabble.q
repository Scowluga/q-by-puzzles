/ Scrabble tile values
TV:.Q.a!1 3 3 2 1 4 2 4 1 8 5 1 3 1 1 3 10 1 1 1 1 4 4 8 4 10;

/ Word list - currently the Unix dictionary
WL:system "curl http://wiki.puzzlers.org/pub/wordlists/unixdict.txt";

/ Frequency count of a word
fc:{count each group x}

/ Whether one frequency count is a superset of another (contains all chars)
/ The first frequency count is allowed to contain wildcards "_" indicating blanks that match any tile
fss:{
  missing:neg sum diff where 0>diff:x-y;
  missing<=$[x["_"]=0N; 0; x["_"]] }      / TODO: surely there must be a better way of doing this than a cond

/ Table of words sorted in descending order of word scores
DT:`score xdesc ([]
  word:WL;
  length:count each WL;
  freqs:fc each WL;
  score:{sum TV x}each WL);

/ Word builder
by_score:{select word,score from DT where fc[x]fss/:freqs};
bingo:{select word,score from DT where (length=7)&fc[x]fss/:freqs};
