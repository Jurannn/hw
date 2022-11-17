


data p1;
input x y;
label x = 'x' y = 'y';
cards;
0.5 0.68
0.5 1.58
1 0.45
1 2.66
2 2.50
2 2.04
4 6.19
4 7.85
8 56.1
8 54.2
9 89.8
9 90.2
10 147.7
10 146.3
;
run;


data p11;
 set p1;
 lny = log(y) ;
run;

proc reg data = p11;
model lny = x;
run;


/*(e)*/

proc nlin data = p11 method = gauss outest = est12_8 plots = residuals(residualtype = raw);
parms theta1 = 0.75226 theta2 = 0.53261;
model y = theta1 * exp(theta2*x);
output out = p111 student = rs p = yp;
run;
quit;


proc capability data = p111;
var rs;
qqplot rs;
run;

proc glm data = p11;
class x;
model y=x / noint;
run;
quit;

/*12.11*/

data ex12_11;
input x y @@;
label x = 'x' y = 'y';
cards;
8 0.49 8 0.49 10 0.48 10 0.47 10 0.48 10 0.47 12 0.46 12 0.46
12 0.45 12 0.43 14 0.45 14 0.43 14 0.43 16 0.44 16 0.43 16 0.43
18 0.46 18 0.45 20 0.42 20 0.42 20 0.43 22 0.41 22 0.41 22 0.40
26 0.41 26 0.40 26 0.41 28 0.41 28 0.40 30 0.40 30 0.40 30 0.38
32 0.41 32 0.40 34 0.40 36 0.41 36 0.38 38 0.40 38 0.40 40 0.39
42 0.39
;
run;

/*a*/
symbol1 v=dot i=none;
proc gplot data = ex12_11;
plot y*x = 1;
run;


/*b*/

proc nlin data = ex12_11 method = newton outest = est12_11_b plots = residuals(residualtype = raw);
parms theta1 = 0.38 theta2 = - 0.11 theta3 = 0.056;
model y = theta1 - theta2 * exp(-theta3*x);
output out = ex12_11_bb student = rs p = yp;
run;
quit;

/*e*/

proc nlin data = ex12_11 df = d method = newton UNCORRECTEDDF TOTALSS;
model y = theta1 - theta2 * exp(-theta3*x);
parms theta1 = 0.38 theta2 = - 0.11 theta3 = 0.056;
run;
quit;

proc capability data = ex12_11_bb;
var rs;
qqplot rs;
run;


proc glm data = ex12_11;
class x;
model y=x / noint;
run;
quit;


/*12.15*/

data ex12_15;
input x y;
label x = 'x' y = 'y';
cards;
273 4.6
283 9.2
293 17.5
303 31.8
313 55.3
323 92.5
333 149.4
343 233.7
353 355.1
363 525.8
373 760.0
;
run;


/*(a)*/
symbol1 v=dot i=none;
proc gplot data = ex12_15;
plot y*x = 1;
run;


/*(b)*/
proc reg data = ex12_15;
model y = x;
run;

/*(c)*/
data ex12_15_c;
set ex12_15;
lny = log(y);
t = -1/x;
run;

symbol1 v=dot i=none;
proc gplot data = ex12_15_c;
plot lny*t = 1;
run;

proc reg data = ex12S_15_c;
model lny = t;
run;


/*(d)*/

data ex12_15_d;
set ex12_15;
lny = log(y);
run;

proc nlin data = ex12_15_d method = newton outest = est12_15 plots = residuals(residualtype = raw);
parms theta1 = 20.61 theta2 = 5200 theta3 = -1 ;
model lny =theta1 - theta2/x + theta3*x*x;
run;
quit;
