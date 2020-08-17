clear all;
close all;

% *** Berechne Rechenzeit - 1/2 ***
StartZeit = cputime;
% ------------------------------------------------------------

% *** INPUT ***

%Raumvariablen
Rasterlaenge = 50; % Die Interpolierte Matrix soll eine Rasterlaenge von "Rasterlaenge" Metern haben. Entspricht h * 1000 Metern

% Zeitvariablen
Tage = 400;
delta_t = 0.05;
Zeitschritte = floor(Tage/delta_t);

% Infektionsvariablen
BasisErkrankungsrate = 0.205; %Rate der Infektionsverbreitung bei einer Kontaktrate: Wahrscheinlichkeit des Kontakts eines Infizierten mit einem Anfälligen. 
Wechselrate = (1/14);

% Diffussionsvariablen
c_0 = 0.01; %Basisdiffusionskoeffzient (gering wählen, da bei BevDichte = 0 dieser Wert genommen wird)
%a = 1/10000; % Proportionalitätskonstante des linearen Wachstums (Steigung) (Wird unten automatisch berechnet)

% ------------------------------------------------------------

% *** Bevoelkerungsmatrix ***
B = BevDichteMatrix();
[B_Interpoliert, M, N, h] = InterpoliereBevDichteMatrix(B, Rasterlaenge);
% ------------------------------------------------------------

% *** Ortsabhängige Diffusionskoeffizientenmatrix ***
BasisKoeffizientFaktor = 100;
a = ((BasisKoeffizientFaktor-1)*c_0)*(1/max(B_Interpoliert(:))); % Der Diffusionskoeffizient ist an der Stelle mit der höchsten Bev Dichte, "BasisKoeffizientFaktor" mal so hoch wie der Basisdiffusionskoeffizient
C_Linear = LineareDiffusionskoeffizientMatrix(B_Interpoliert,c_0, a);
%k = 0.5; %Steilheit der Kurve bei nicht linearem Anstieg
%C_NichtLinear = NichtLineareDiffusionskoeffizientMatrix(B_Interpoliert,c_0, k);
%C_StueckweiseStetig = StueckweiseStetigeDiffusionskoeffizientMatrix(B_Interpoliert,c_0, c_1,1000);
% ------------------------------------------------------------

% *** Systemmatrix für ortsabhängigen Diffusionskoeffizienten ***
% Achtung Diffusionskoeffizient c (bzw. a) nicht gleich der Infektionsrate (Erkrankungsrate) c
A_h = OrtsabhaengigeSystemmatrix(M,N,h, C_Linear);
% ------------------------------------------------------------

% *** Matrix mit den Startbedingungen der Infektion ***
[x_KH,y_KH,r_KH] = PositionVizentiusKrankenhausLandau(B_Interpoliert, h);
InfizierteStartAnzahl = 1;
InfizierteStartMatrix = InfizierteStartbedingungMatrix(B_Interpoliert, h, [x_KH, y_KH, r_KH, InfizierteStartAnzahl]);
clear *_KH; %Alle Variablen die mit _KH enden werden gelöscht, da nicht mehr benötigt.
% ------------------------------------------------------------

% *** Tag 0 ***
B = reshape(B_Interpoliert',N*M,1); %B ueberschreiben mit Vektor der Interpolierten Werte
u_i_alt = 1*reshape(InfizierteStartMatrix',N*M,1);
u_s_alt = B.-u_i_alt;
% ------------------------------------------------------------

% *** Berechnung der Loesung fuer alle Zeitschritte ***
for t=1:Zeitschritte
  Erkrankungsrate = slowdown(t*delta_t) * BasisErkrankungsrate;
  
  u_i = u_i_alt + delta_t * (A_h * u_i_alt + F_I(Erkrankungsrate, B, Wechselrate, u_i_alt, u_s_alt));
  u_s = u_s_alt + delta_t * (A_h * u_s_alt + F_S(Erkrankungsrate, B, Wechselrate, u_i_alt, u_s_alt));
  
  u_i_alt = u_i;
  u_s_alt = u_s;
  
  Erkrankungsrate_Speicher(1,t)=Erkrankungsrate;
  u_i_Speicher(:,t)=u_i;
  u_s_Speicher(:,t)=u_s;
endfor
% ------------------------------------------------------------

% *** Plotten der Loesungen ***
fig_index=floor([1:Tage]./delta_t);

j=0;
 for i=fig_index
  Loesung=reshape(u_i_Speicher(:,i),N,M)'; % Matrix mit N(Zeilen)x M(Spalten)
  aktuell_Infizierte=sum(Loesung(:))*h^2;
  aktuell_Infizierte_Speicher(:,i*delta_t)=aktuell_Infizierte;
  %disp(['Figure ',num2str(i/fig_index(1))]);
  j=j+1;
  figure(j);
  surface(Loesung*h^2, "EdgeColor", "none")
 % colormap: autumn,  hsv jet ocean
  colormap ("jet")
  colorbar 
  axis([0 N 0 M 0 max(u_i_Speicher(:))*h^2])
  title (["Aktuell Infizierte"]);
  %ylabel("y")
  xlabel(["Tag: ", num2str(delta_t*i) "\tAktuell Infizierte: " num2str(aktuell_Infizierte) "\tErkrankungsrate: " num2str(Erkrankungsrate_Speicher(1,delta_t*i))])
  %Optional: Speicherung der Bilder
  if(true)
    filename=["Images/Aktuell_Infizierte_Tag_" num2str(j) "_von_" num2str(Tage) "_Raster_" num2str(M) "x" num2str(N) "_" num2str(Rasterlaenge) "m" ".jpg"];
    saveas(j, filename)
    close (j)
  endif
endfor
% ------------------------------------------------------------

% *** Berechne Rechenzeit - 2/2 ***
Zeit = RechenZeit(cputime - StartZeit);
disp(["Benoetigte Rechenzeit: " Zeit]);
% ------------------------------------------------------------

% *** Alles abspeichern ***
save(["Arbeitsumgebung/Aktuelle_Infizierte_" num2str(floor(StartZeit)) "_" num2str(Tage) "_Tage_Raster_" num2str(M) "x" num2str(N) "_" num2str(Rasterlaenge) "m.mat" ])
% ------------------------------------------------------------