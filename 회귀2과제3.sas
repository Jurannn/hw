
/*13.6*/
data table136;
input failures months @@; cards;
5 18 3 15 0 11 1 14 4 23 0 10 0 5 1 8 0 7 0 12 0 3 1 7 0 2 7 30 0 9
;
run;


proc genmod data=table136;
model failures = months / dist=poi aggregate;
output out = table136_1  pred=fitted;
run; quit;



proc genmod data = table136 plots;
model failures= months / dist=poi type1 type3 ;
output out=out_table136 pred=fitted;
run;


proc sgplot data = out_table136;
xaxis label = 'Months';
yaxis label="Number of failures";
scatter x=months y=fitted ;
scatter x=months y=failures;
run;


proc genmod data=table136;
model failures = months months*months/ dist=poi;
run; quit;


/*13.7*/

data table137;
input obs y x1 x2 x3 x4 @@;
cards;
1 2 50 70 52 1.0 2 1 230 65 42 6.9 3 0 125 70 45 1.0 4 4 75 65 68 0.5 5 1 70 65 53 0.5 6 2 65 70 46 3.0 7 0 65 60 62 1.0 8 0 350 60 54 0.5 
9 4 350 90 54 0.5 10 4 160 80 38 0.0 11 1 145 65 38 10.0 12 4 145 85 38 0.0 13 1 180 70 42 2.0 14 5 43 80 40 0.0 15 2 42 85 51 12.0 
16 5 42 85 51 0.0 17 5 45 85 42 0.0 18 5 83 85 48 10.0 19 0 300 65 68 10.0 20 5 190 90 84 6.0 21 1 145 90 54 12.0 22 1 510 80 57 10.0 
23 3 65 75 68 5.0 24 3 470 90 90 9.0 25 2 300 80 165 9.0 26 2 275 90 40 4.0 27 0 420 50 44 17.0 28 1 65 80 48 15.0 29 5 40 75 51 15.0 
30 2 900 90 48 35.0 31 3 95 88 36 20.0 32 3 40 85 57 10.0 33 3 140 90 38 7.0 34 0 150 50 44 5.0 35 0 80 60 96 5.0 36 2 80 85 96 5.0 
37 0 145 65 72 9.0 38 0 100 65 72 9.0 39 3 150 80 48 3.0 40 2 150 80 48 0.0 41 3 210 75 42 2.0 42 5 11 75 42 0.0 43 0 100 65 60 25.0 
44 3 50 88 60 20.0  
;
run;


proc genmod data=table137;
model y = x1-x4 / dist=poi link = log;
output out = table137_1  pred=fitted;
run; quit;

