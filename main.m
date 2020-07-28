 clf;
 clear all;
 close all;
 %Ausbreitungskoeffizient (Diffusionskoeffizient)
 c = 0.1;
 %Infektionsrate
 infektionsrate=0.3258;
 
 %Zeitvariablen
 tage = 150;
 zeitSchritte = 0.5;
 
 
 %Bevölkerungsmatrix --------- 
 B = getBevDichteMatrix();
 sizeX= size(B)(2); %entspricht xend also x in km
 sizeY= size(B)(1); %entspricht yend also y in km
 N=sizeX*10; %sizeX ist x in km -> * 10 = 100m Raster
 h = sizeX/(N);
 M=sizeY/h;
 colormap ("hot");
 x = 0:1:size(B)(2)-1;  y = 0:1:size(B)(1)-1;
 xi = linspace (min (x), max (x), N); %Anzahl der Unterteilungen
 yi = linspace (min (y), max (y), M)'; %Anzahl der Unterteilungen
 BInt = interp2 (x,y,B,xi,yi, "cubic");
 surface (xi,yi,BInt);
 [x,y] = meshgrid (x,y);
 hold on;
 plot3 (x,y,B,"bo");
 title ("Bevoelkerungsdichte Landau");
 ylabel("y")
 xlabel("x")
 
if(size(x)(2)>size(y)(2))
 axis_value = size(x)(2)-1;
else
 axis_value = size(y)(2)-1;
endif
 axis([0 axis_value 0 axis_value])
 colorbar
 hold off;
 %--------------------------------------------- 
 %Systemmatrix --------- 

 A_h = 1*calcSysMatrix(N,M,c,h);
 
 B_vec = 1*reshape(BInt',N*M,1);
 
 %infizierteStartMatrix------------------- 
 LoesungsVector_alt = 1*reshape(getInfizierteStartMatrix(N,M)',N*M,1);
 %--------------------------------------------- 
 
 F=@(u) (infektionsrate./B_vec).*u.*(B_vec-u);
 
 for t=1:1:30
   
 LoesungsVector =  LoesungsVector_alt + A_h*LoesungsVector_alt*zeitSchritte + 1*F(infektionsrate,B_vec, LoesungsVector_alt)*zeitSchritte; 
 LoesungsVector_alt = LoesungsVector;
 LoesungsSpeicherMatrix(:,t) = LoesungsVector;  
endfor

