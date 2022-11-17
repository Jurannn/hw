
proc import datafile= "C:\Users\USER\Desktop\다변량\data\iris1.csv" dbms = csv out = iris;
getnames = yes;
guessingrows = max;
run;

ods pdf file = "C:\Users\USER\Desktop\다변량\report.pdf";

proc reg data = iris;
model sepal_length = sepal_width; run;

ods pdf close;




/*IML실습*/
/*매트릭스 생성*/

proc iml;
A = {1 2, 3 4}
C = 3
D = C * A;
print D;
run;


/*행렬연산*/
proc iml;
A = {1 2, 3 4};
B = I(nrow(A));
C = A + B;
print B C; run;

proc iml;
A = {1 2. 3 4};
B = {2 0, 2 0};
C = A*B;
print C; run;

/*elementwise로 곱해줌 -> 같은 위치의 원소끼리 곱해줌*/
proc iml;
A = {1 2. 3 4};
B = {2 0, 2 0};
C = A#B;
print A, B, C; run;

/*elementwise로 곱해줌 -> 같은 위치의 원소끼리 power 해줌*/
proc iml;
A = {1 2. 3 4};
B = {2 0, 2 0};
C = A##B;
print A, B, C; run;

proc iml;
A = {1 2, 3 4}
A_trans = A`;
A_eigen = eigval(A)[,1]; /*첫번째 열만 선택하기 위해서 [,1] 을 해줌*/
print A; run;


data one;
input x1 x2 x3;
cards;
2 1 1
2 1 0
-1 -2 -1
;
run;

proc iml;
use one; /*one을 가져와서*/
read all into A; /*iml에서 A라고 쓸거임*/
call eigen (val, vec, A); /*value, vector value와 벡터를 넣을 매트릭스 생성*/
print val, vec;
run;

/*분광분해*/

proc iml;
use one;
read all into A;
call eigen (val, vec, A); /*고유값 저장, 고유벡터 저장, */
val = diag(val[,1]); /*대각행렬로 만들기 위해 diag에 넣음*/
A_2 = vec * val * inv(vec); /*분광분해 고유벡터P * 고유값으로 이루어진 대각행렬 * 고유벡터P의 인버스*/
print A, A_2;
run;
