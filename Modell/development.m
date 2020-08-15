clear
B=BevDichteMatrix();
MenschenInB=sum(sum(B))*1^2
[BInt,M,N,h]=InterpoliereBevDichteMatrix(B,125);
MenschenInBInt=sum(sum(BInt))*h^2
h^2*M*N