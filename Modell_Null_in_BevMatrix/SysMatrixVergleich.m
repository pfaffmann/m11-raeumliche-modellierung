clear all;
close all;

% *** Berechne Rechenzeit - 1/2 ***

% ------------------------------------------------------------

% *** INPUT ***

%Raumvariablen
Rasterlaenge = 18; % Die Interpolierte Matrix soll eine Rasterlaenge von "Rasterlaenge" Metern haben. Entspricht h * 1000 Metern

% Zeitvariablen
Tage = 40; %Muss dann erhöht werden.
delta_t = 0.05;
Zeitschritte = floor(Tage/delta_t);

% Infektionsvariablen
BasisErkrankungsrate = 0.3852; %Rate der Infektionsverbreitung bei einer Kontaktrate: Wahrscheinlichkeit des Kontakts eines Infizierten mit einem Anfälligen. 
Wechselrate = (1/14);

% Diffussionsvariablen
c_0 = 0.1; %Basisdiffusionskoeffzient (gering wählen, da bei BevDichte = 0 dieser Wert genommen wird)
%a = 1/10000; % Proportionalitätskonstante des linearen Wachstums (Steigung) (Wird unten automatisch berechnet)

% ------------------------------------------------------------

% *** Bevoelkerungsmatrix ***
B = BevDichteMatrix();
[B_Interpoliert, M, N, h] = InterpoliereBevDichteMatrix(B, Rasterlaenge);
% ------------------------------------------------------------

% *** Ortsabhängige Diffusionskoeffizientenmatrix ***
BasisKoeffizientFaktor = 50;
a = ((BasisKoeffizientFaktor-1)*c_0)*(1/max(B_Interpoliert(:))); % Der Diffusionskoeffizient ist an der Stelle mit der höchsten Bev Dichte, "BasisKoeffizientFaktor" mal so hoch wie der Basisdiffusionskoeffizient
C_Linear = LineareDiffusionskoeffizientMatrix(B_Interpoliert,c_0, a);
%k = 0.5; %Steilheit der Kurve bei nicht linearem Anstieg
%C_NichtLinear = NichtLineareDiffusionskoeffizientMatrix(B_Interpoliert,c_0, k);
%C_StueckweiseStetig = StueckweiseStetigeDiffusionskoeffizientMatrix(B_Interpoliert,c_0, c_1,1000);
% ------------------------------------------------------------

% *** Systemmatrix für ortsabhängigen Diffusionskoeffizienten ***
% Achtung Diffusionskoeffizient c (bzw. a) nicht gleich der Infektionsrate (Erkrankungsrate) c
disp(["Dimension der Systemmatrizen: " num2str(N*M) "x" num2str(N*M)]);
StartZeit1 = cputime;
A_h1 = OrtsabhaengigeSystemmatrix(M,N,h, C_Linear);
EndZeit1 = cputime - StartZeit1;
Zeit1 = RechenZeit(EndZeit1);
disp(["Benötigte Rechenzeit mit einer for Schleife: " Zeit1]);
clear A_h1
% ------------------------------------------------------------

% *** Systemmatrix für ortsabhängigen Diffusionskoeffizienten ***
% Achtung Diffusionskoeffizient c (bzw. a) nicht gleich der Infektionsrate (Erkrankungsrate) c
StartZeit2 = cputime;
A_h2 = newSysMatrix(M,N,h, C_Linear);
EndZeit2 = cputime - StartZeit2;
Zeit2 = RechenZeit(EndZeit2);
disp(["Benötigte Rechenzeit mit 2 for Schleifen: " Zeit2]);
clear A_h2
% ------------------------------------------------------------