[ prob ]
106-104 + COV-effects(CRCL, AGE) on CL

$PLUGIN autodec nm-vars

$NMEXT
root = "cppfile"
project = "."
run = 106

$CMT GUT CENT PERIPH

$PARAM
WT   = 70
EGFR = 90
ALB  = 4.5
AGE  = 35

$PK
V2WT   = LOG(WT/70);
CLWT   = LOG(WT/70)*0.75;
CLEGFR = LOG(EGFR/90)*THETA(6);
CLAGE  = LOG(AGE/35)*THETA(7);
V3WT   = LOG(WT/70);
QWT    = LOG(WT/70)*0.75;
CLALB  = LOG(ALB/4.5)*THETA(8);

KA  = EXP(THETA(1)+ETA(1));
V2  = EXP(THETA(2)+V2WT+ETA(2));
CL  = EXP(THETA(3)+CLWT+CLEGFR+CLAGE+CLALB+ETA(3));
V3  = EXP(THETA(4)+V3WT);
Q   = EXP(THETA(5)+QWT);

S2 = V2/1000; // dose in mcg, conc in mcg/mL

K20 = CL/V2;
K23 = Q/V2;
K32 = Q/V3;

F1 = 1.00;

$DES

DADT(1) = -KA  * A(1);
DADT(2) =  KA  * A(1) - (K20 + K23) + K32*A(3);
DADT(3) =  K23 * A(2) - K32 * A(3);

$ERROR
capture IPRED = A(2)/S2;
capture Y = IPRED * (1+EPS(1));
