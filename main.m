 clf;
 clear all;
 close all;
 %Ausbreitungskoeffizient (Diffusionskoeffizient)
 c = 0.1;
 %Infektionsrate
 infektionsrate=0.3258;
 %Wechselrate
 w=(1/14);
 %Zeitvariablen
 tage = 150;
 delta_t = 0.5;
 Zeitschritte = floor(tage/delta_t);
 
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
 spy(A_h)
 B = 1*reshape(BInt',N*M,1);
 
 %infizierteStartMatrix------------------- 
 u_i_alt = 1*reshape(getInfizierteStartMatrix(N,M)',N*M,1);
 u_s_alt = B.-u_i_alt; 
 %--------------------------------------------- 
 LoesungsSpeicherMatrix(:,1) = u_i_alt;
 LoesungsSpeicherMatrixS(:,1) = u_s_alt;
 F=@(ui,us,t) (infektionsrate./B).*ui.*us;
 
 for t=1:Zeitschritte
   
 reaktion = F(u_i_alt, u_s_alt,t*delta_t);
   
 u_i = u_i_alt + A_h * u_i_alt * delta_t + (reaktion - w .* u_i_alt) * delta_t;  
 u_s = u_s_alt + A_h * u_s_alt * delta_t - reaktion * delta_t;
 u_i_alt = u_i;
 u_s_alt = u_s;
 LoesungsSpeicherMatrix(:,t+1) = u_i;
 LoesungsSpeicherMatrixS(:,t+1) = u_s;
endfor

