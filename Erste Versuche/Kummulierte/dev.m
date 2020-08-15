B=calcSysMatrix(50,40,1,9);
%spy (B);

C=getInfizierteStartMatrix(50,40)
close all;
surface(1:50,1:40,C)



