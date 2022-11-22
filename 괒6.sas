


ods pdf file = "C:\Users\USER\Desktop\다변량\report06.pdf";


/*8.7*/

proc import datafile = "C:\Users\USER\Desktop\다변량\과제\table51.csv" out = table51 dbms = csv replace;
run;

proc iml;
	 use table51;
	 read all into data;
	 y1 = data[1:32,]; y2 = data[33:64,];
	 Spl = (1/(32+32-2)) * (31*cov(y1) + 31*cov(y2));
	 a = inv(Spl) * (t(mean(y1)) - t(mean(y2)));
	 astar = (diag(Spl)##(1/2) * a);
	 y11 = y1[,1];
	 y12 = y1[,2];
	 y13 = y1[,3];
	 y14 = y1[,4];
	 y21 = y2[,1];
	 y22 = y2[,2];
	 y23 = y2[,3];
	 y24 = y2[,4];
	 t1 = (mean(y11) - mean(y21)) / (sqrt(Spl[1,1] * (1/32 + 1/32)));
	 t2 = (mean(y12) - mean(y22))/(sqrt(Spl[2,2]*(1/32 + 1/32)));
	 t3 = (mean(y13) - mean(y23))/(sqrt(Spl[3,3]*(1/32 + 1/32)));
	 t4 = (mean(y14) - mean(y24))/(sqrt(Spl[4,4]*(1/32 + 1/32)));
	 print astar, t1, t2, t3, t4;
	 run;


/*8.8*/

proc import datafile = "C:\Users\USER\Desktop\다변량\과제\table55.csv" out = table55 dbms = csv replace;
run;

proc iml;
	 use table55;
	 read all into data;
	 y1 = data[1:19,]; y2 = data[20:39,];
	 Spl = (1/(19+20-2)) * (18*cov(y1) + 20*cov(y2));
	 a = inv(Spl) * (t(mean(y1)) - t(mean(y2)));
	 astar = (diag(Spl)##(1/2) * a);
	 y11 = y1[,1];
	 y12 = y1[,2];
	 y13 = y1[,3];
	 y14 = y1[,4];
	 y21 = y2[,1];
	 y22 = y2[,2];
	 y23 = y2[,3];
	 y24 = y2[,4];
	 t1 = (mean(y11) - mean(y21)) / (sqrt(Spl[1,1] * (1/19 + 1/20)));
	 t2 = (mean(y12) - mean(y22))/(sqrt(Spl[2,2]*(1/19 + 1/20)));
	 t3 = (mean(y13) - mean(y23))/(sqrt(Spl[3,3]*(1/19 + 1/20)));
	 t4 = (mean(y14) - mean(y24))/(sqrt(Spl[4,4]*(1/19 + 1/20)));
	 print astar, t1, t2, t3, t4;
	 run;


/*9.7*/
proc iml;
 use table55;
 p = 1:19;
 q = 20:39;
 read point p into a_group;
 read point q into b_group;
 s1 = cov(a_group);
 s2 = cov(b_group);
 y1 = t(mean(a_group));
 y2 = t(mean(b_group));
 Spl = (1 / (19 + 20 - 2)) * ( (19-1) * s1 + (20-1) *s2);
 Sinv = inv(Spl);
 z = t(y1-y2)*Sinv;
 m = (1/2)*z*(y1+y2);
print z, m;



proc discrim data = table55 pool = test simple listerr out = table551;
	class group;
	var y1-y4;
	priors prop;
run;


/*9.8*/
proc import datafile = "C:\Users\USER\Desktop\다변량\과제\table57.csv" out = table57 dbms = csv replace;
run;

proc print data = table57; run;

proc iml;
 use table57;
 p = 1:39;
 q = 40:73;
 read point p into a_group;
 read point q into b_group;
 s1 = cov(a_group);
 s2 = cov(b_group);
 y1 = t(mean(a_group));
 y2 = t(mean(b_group));
 Spl = (1 / (39 + 34 - 2)) * ( (39-1) * s1 + (34-1) *s2);
 Sinv = inv(Spl);
 z = t(y1-y2)*Sinv;
 m = (1/2)*z*(y1+y2);
print z, m;



proc discrim data = table57 pool = test simple listerr out = table571;
	class group;
	var y1-y6;
	priors prop;
run;

ods pdf close;
