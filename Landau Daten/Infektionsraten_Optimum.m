clear all;
%K ist das Intervall von Infektionsraten, welches im folgenden Skript untersucht wird
%Durch mehrmaliges Durchführen und strategisches Veraendern des Intervalls lässt
%sich ein Optimum theoretisch auf beliebig viele Stellen genau bestimmen.
K=[0.3229:0.0000001:0.3231];

%Parameter des SIR Models
NM=55000 % Kapazitätsgrenze, 2/3 der deutschen Bevölkerung

w=1/14;       % Wechselrate zu den Genesenen
d=0.003       % Todesrate
r=0.1         %Anteil der erfassten Infizierten

 A=coronaData();

 inf_falleWHO=A(1,:);
  inf_falleWHOrecovered=A(3,:);
 inf_falleWHOtoten=A(2,:);
 
 inf_falleWHOaktuell=inf_falleWHO-inf_falleWHOrecovered;
 n=length(inf_falleWHO);
 timesWHO=[0:1:n-1];

 times=(0:0.1:180);
 
 NORM=zeros(columns(K),2);
 
 MEAN=zeros(columns(K),2);
 
for c1=2:columns(K)
  
  c=K(1,c1);
  
     %Slowdown-Funktion
for i=1:length(timesWHO)
cc(i)=slowdown3 (timesWHO (i), 25)*c;
endfor 

  %Anfangsbedingungen
    yo=[NM-16/1000;16/1000;0];
    
    f=@(y,x) [-c*slowdown3(x,25)*y(1)*y(2)/(r*NM);c*slowdown3(x,25)*y(1)*y(2)/NM-w*y(2);w*y(2)-0*y(2)];
    y = lsode (f, yo, times);

       %relat. Fehler Infizierte

%Interpolation der Funktionswerte an die RKI-Zeiten (Tage)
I=interp1 (times, y(:,2), timesWHO+1);
abs_I=abs(I-inf_falleWHOaktuell/1000);
rel_I=abs(I-inf_falleWHOaktuell/1000)./(inf_falleWHOaktuell/1000);

%Fehlermaß
maas_I=norm(abs_I)/norm(inf_falleWHOaktuell/1000)
%weiterer  Fehlermaß Durchschnitt und Euklid-Norm
rel_I_mean=mean(rel_I)
rel_I_norm=norm(rel_I);


%relat. Fehler Genesene/Toten
R=interp1 (times, y(:,3), timesWHO+1);
abs_R=abs(R-inf_falleWHOrecovered/1000);
rel_R=abs(R-inf_falleWHOrecovered/1000)./(inf_falleWHOrecovered/1000);

%Fehlermaß
maas_R=norm(abs_R)/norm(inf_falleWHOrecovered/1000)
% weiterer Fehlermaß: Durchschnitt und Euklid-Norm
rel_R_mean=mean(rel_R(36:length(timesWHO)))
rel_R_norm=norm(rel_R(36:length(timesWHO)));

NORM(c1,1)=rel_I_norm;
NORM(c1,2)=rel_R_norm;

MEAN(c1,1)=rel_I_mean;
MEAN(c1,2)=rel_R_mean;
clear y;
endfor


NORM_Vektor=sqrt(NORM(:,1).^2+NORM(:,2).^2);
MEAN_Vektor=sqrt(MEAN(:,1).^2+MEAN(:,2).^2);

Minimum_NORM=min(NORM_Vektor(2:end,1));
Minimum_MEAN=min(MEAN_Vektor(2:end,1));

[n1,n2]=find(NORM_Vektor==Minimum_NORM);
[m1,m2]=find(MEAN_Vektor==Minimum_MEAN);

c_Minimum_Wert=K(1,n1);