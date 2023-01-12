$PLUGIN Rcpp


$PARAM   // parameters
KA = 1.2
VC = 21
THETA1 = 1
WT = 70
THETA_RUV = 0.025
BASE = 1

[ cmt ] // $CMT alt style
GUT CENT

$OMEGA
0.1 0.2

$OMEGA
1

$OMEGA @block
0.1
0.01 0.2
0.01 0.01 0.3

$SIGMA
1

$PK // [ main ]

double TVCL  = THETA1 * pow(WT / 70, 0.75);
double CL = TVCL * exp(ETA(1));

F_CENT = 0.89;
ALAG_GUT = 0.25;
D_CENT = 0.5;
R_CENT = 1;

CENT_0 = BASE;

CL = std::max(10.0, CL);

int flag = CL > 10 ? 1 : 0;

[ des ] // $DES C++ code blocks

double rate_out = (CL/VC) * CENT;

dxdt_GUT = -KA * GUT;

dxdt_CENT = KA * GUT - rate_out;

[ error ] // $ERROR C++
double CP = CENT / VC;
//capture Y = CP * (1+EPS(1));
double W = sqrt(THETA_RUV);
capture Y = CP + W*EPS(1);


// capture CP = CENT / VC;
double draw = R::rnorm(0, 1);
int    flag2 = R::rbinom(1, 0.5);


[ capture] // $TABLE
CP draw flag2


