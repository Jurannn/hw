

/*(1)*/

data data1;
input x y @@;
cards;
400 0 220 1 490 0 210 1 500 0 270 0 200 1 470 0 480 0 310 1 240 1 490 0 420 0
330 1 280 1 210 1 300 1 470 1 230 0 430 0 460 0 220 1 250 1 200 1 390 0
;
run;



proc logistic descending;
model y = x / scale = none aggregate;
run; quit;

proc logistic descending;
model y = x x*x/ scale = none aggregate;
run; quit;





/*(2)*/
data data2;
input x y @@;
cards;
38000 0 51200 1 39600 0 43400 1 47700 0 53000 0 41500 1 40800 0 45400 1 52400 1
38700 1 40100 0 49500 1 38000 0 42000 1 54000 1 51700 1 39400 0 40900 0  52800 1
;
run;


proc logistic descending;
model y = x / scale = none aggregate;
run; quit;


proc logistic descending;
model y = x x*x/ scale = none aggregate;
run; quit;
