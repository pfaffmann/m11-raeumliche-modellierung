 clf;
 clear all;
 close all;
 %Ausbreitungskoeffizient (Diffusionskoeffizient)
 %beschreibt nur die Ausbreitung im Raum
 c = 0.1;
 
 %Infektionsrate
 %Wkeit, dass eine Person im Raum infiziert wird
 infektionsrate=0.3258;
 
 %Wechselrate
 w=(1/14);
 
 %Zeitvariablen
 tage = 200;
 delta_t = 0.01;
 Zeitschritte = floor(tage/delta_t);
 
 %-------
 %slowdown für c)!
 
 %-------
 
 %Bev�lkerungsmatrix --------- 
 B = getBevDichteMatrix();
 sizeX= size(B)(2); %entspricht xend also x in km
 sizeY= size(B)(1); %entspricht yend also y in km
 N=sizeX*12; %sizeX ist x in km -> * 10 = 100m Raster
 h = sizeX/(N);
 M=sizeY/h;
 colormap ("hot");
 
 %B=zeros(4,5).+232;
 
 x = 0:1:size(B)(2)-1;  y = 0:1:size(B)(1)-1;
 xi = linspace (min (x), max (x), N); %Anzahl der Unterteilungen
 yi = linspace (min (y), max (y), M)'; %Anzahl der Unterteilungen
 BInt = interp2 (x,y,B,xi,yi, "cubic");
 figure(1001)
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
 %spy(A_h)
 B = 1*reshape(BInt',N*M,1);
 
 %infizierteStartMatrix------------------- 
 u_i_alt = 10*reshape(getInfizierteStartMatrix(N,M,h)',N*M,1); 
 u_s_alt = B.-u_i_alt; 
 %--------------------------------------------- 
 figure(1000)
 surface(xi,yi,reshape(u_i_alt,N,M)', "EdgeColor", "none");
 title (["Anfangszustand"]);
 
 for t=1:Zeitschritte
 %LoesungsSpeicherMatrix(:,1) = u_i_alt;
 %LoesungsSpeicherMatrixS(:,1) = u_s_alt;
 infektionsrate_slow=slowdown3(t*delta_t)*infektionsrate;

 F_S=@(ui,us,t) -1*(infektionsrate_slow./B).*ui.*us; 
 %slowdown in c) berücksichtigen!
 
 F_I=@(ui,us,t) (infektionsrate_slow./B).*ui.*us-w*ui;
 

   
%reaktion = F(u_i_alt, u_s_alt,t*delta_t);
   
u_i = u_i_alt + delta_t* ( A_h*u_i_alt + (F_I(u_i_alt, u_s_alt,t*delta_t)-w.*u_i_alt));

u_s =  u_s_alt + delta_t*(A_h*u_s_alt+F_S(u_i_alt, u_s_alt,t*delta_t));

% till here ok - ab einem bestimmten Zeitschritt gehen die Werte gegen unendlich 
% und werden undefiniert - Bevölkerungsmatrix wird nicht korrekt berücksichtigt
u_i_alt = u_i;
u_s_alt = u_s;
LoesungsSpeicherMatrix(:,t+1) = u_i;
LoesungsSpeicherMatrixS(:,t+1) = u_s;
endfor

fig_index=floor([1:tage]./delta_t)

j=0;
 for i=fig_index
  sol_matrix=reshape(LoesungsSpeicherMatrix(:,i),N,M); % Matrix mit N(Zeilen)x M(Spalten)
  sol_matrix=sol_matrix';
  total_Infizierte=sum(sum(sol_matrix))*h^2
  total_Infizierte_Matrix(:,i*delta_t)=total_Infizierte;
  disp(['Figure ',num2str(i/fig_index(1))]);
  j=j+1;
  figure(j);
  surface(xi,yi,sol_matrix*h^2, "EdgeColor", "none")
 % colormap: autumn,  hsv jet ocean
  colormap ("jet")
  colorbar 
  axis([0 sizeX 0 sizeY 0 max(max(LoesungsSpeicherMatrix))*h^2])
  title (["Loesung in t=", num2str(delta_t*i)]);
  ylabel("y")
  xlabel("x")
  %Optional: Speicherung der Bilder
  test=["a-Fig_", num2str(j),".jpg"]
  saveas(j, test)
endfor
