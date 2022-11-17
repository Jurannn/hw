
/**example 2.1 : 선형모형 적합**/

data pop;
infile "C:\Users\USER\Desktop\population.txt";
input pop@@;
pop = round(pop/10000);
lnpop = log(pop);
t+1;
t2 = t*t;
year = 1959+5;
run;


proc gplot data = pop;
plot pop*year;
run;


proc reg data = pop;
model pop=t/dw;
output out = out1 p = pred1 r= residual1;
run;


proc gplot data = out1; plot residual1 * year; run;


proc reg data = pop;
model pop=t t2/ dw;
output out = out2 p = pred2 r = residual2;
run;


proc print data = out2;
run;



symbol1 i = join v = plus l = 1 c = black;


proc gplot data = out2;
plot pop*year = 1 pred2 *year = 2/ overlay;
run;


proc gplot data = out2;
plot residual2 *year; run;

proc reg data = pop;
model lnpop = t t2 / dw;
output out = out3 r = residual3; run;

proc gplot data = out3;
plot residual3 * year;
run;

/**example 2.2 : 지시함수를 이용한 계절모형 적합**/


symbol2 v = circle  c = black;

data dept;
   infile "C:\Users\USER\Desktop\depart.txt"; input dept @@;
   lndept = log(dept); t+1;
   date = intnx('month', '1JAN84'D,_n_-1); format date Monyy.;
      mon = month(date);
      if mon = 1 then i1 = 1; else i1 = 0;
      if mon = 2 then i2 = 1; else i2 = 0;
      if mon = 3 then i3 = 1; else i3 = 0;
      if mon = 4 then i4 = 1; else i4 = 0;
      if mon = 5 then i5 = 1; else i5 = 0;
      if mon = 6 then i6 = 1; else i6 = 0;
      if mon = 7 then i7 = 1; else i7 = 0;
      if mon = 8 then i8 = 1; else i8 = 0;
      if mon = 9 then i9 = 1; else i9 = 0;
      if mon = 10 then i10 = 1; else i10 = 0;
      if mon = 11 then i11 = 1; else i11 = 0;
      if mon = 12 then i12 = 1; else i12 = 0;
      run;


proc print data = dept;
run;



proc gplot data = dept; plot dept*date; symbol i = join v = circle l = 1 c = black ; run;


proc gplot data = dept; plot lndept*date; symbol i = join v = circle l = 1 c = black; run;


proc reg; model lndept = t i1-i12/noint dw;
output out = deptout r = residual;
run;


proc gplot data = deptout;
plot residual * date; symbol i = join v = circle l = 1 c = black;
run;

proc arima data = deptout;
identify var = residual;
run;





/**example 2.4 : 자기회귀오차모형 적합**/




proc autoreg data = dept;
model lndept = t i1-i12/ noint backstep nlag = 13 dwprob;
output out = out1 r = residual;
run;



proc gplot data = out1;
plot residual*date = 2;
run;
