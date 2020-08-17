clear;
if(false)
B = BevDichteMatrix();
[B_Interpoliert, M, N, h] = InterpoliereBevDichteMatrix(B, 125);
B_Interpoliert_Normiert = NormiereMatrixAufWert(B_Interpoliert, 10);

StueckweiseStetigeDiffusionskoeffizientMatrix (B, 1 , -1, 1000);



 if(false)
   figure(9990)
   surface (B_Interpoliert);
   title ("Bevoelkerungsdichte Landau");
   ylabel("y")
   xlabel("x")
   colorbar

   figure(9991)
   surface (B_Interpoliert_Normiert);
   title ("Normierte Bevoelkerungsdichte Landau");
   ylabel("y")
   xlabel("x")
   colorbar
 endif
 
 c_0 = 0.01;
 BasisKoeffizientFaktor = 10;
 a = ((BasisKoeffizientFaktor-1)*c_0)*(1/max(B_Interpoliert(:))); % Der Diffusionskoeffizient ist an der Stelle mit der höchsten Bev Dichte, x mal so hoch wie der Basisdiffusionskoeffizient
 %C = LineareDiffusionskoeffizientMatrix(B_Interpoliert,c_0, a);
 C=ones(6,9);
 M=rows(C);
 N=columns(C);
X= OrtsabhaengigeSystemmatrix(M,N,2,C);
Y= newSysMatrix(M,N,2,C);
figure(1)
spy(X)
figure(2)
spy(Y)

isequal(X,Y)


% j=2;
%  c_links  = diag(0.5*(C(j,2:N-1)+C(j,1:N-2)))
 % c_rechts = diag(0.5*(C(j,2:N-1)+C(j,3:N)))
  
%  TMP1 = zeros(6,6);
%  TMP1(2:N-1,1:N-2)=c_links
%  TMP2 = zeros(6,6);
%  TMP2(2:N-1,3:N)=c_rechts
%  B=TMP1+TMP2

 B=zeros(100,125);
 %Startbedingungen =[4,4,2,1;];
 %Startbedingungen =[100,50,10,5;100,100,20,1];
 [x,y,r] = PositionVizentiusKrankenhausLandau(B,0.04);
 Startbedingungen=[x,y,r,1];
 Init=InfizierteStartbedingungMatrix(B, Startbedingungen);
 sum(Init(:));
 endif
 RechenZeit(31.3258415)