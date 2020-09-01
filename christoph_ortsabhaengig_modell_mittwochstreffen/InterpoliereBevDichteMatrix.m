## Copyright (C) 2020 chris
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} InterpoliereBevDichteMatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-08-15

% das vor dem = wird zurückgegeben hier Rückgabeparameter interpolierte Matrix, Höhe des Gebiets M und die Länge des Gebietes N und die Schrittweite h (Abstand zwischen interpolierten Punkten)
function [IntBevMatrix, M, N, h] = InterpoliereBevDichteMatrix (BevMatrix,RasterlaengeInMetern)
%m=rows(B);
%n=columns(B); 
%hInKm=GitterLaengeInMetern/1000;
%M=floor(m/hInKm);
%N=floor(n/hInKm);
%BInt=interp2(1:n,1:m, B, 1:hInKm:N, 1:hInKm:M);

 m = rows(BevMatrix);
 n = columns(BevMatrix);
 
 h = RasterlaengeInMetern/1000; %Schrittweite in km.
 AnzahlPunkteProKilometer = floor(1/h);
 
 M = m * AnzahlPunkteProKilometer;
 N = n * AnzahlPunkteProKilometer;
 
 hilfsM = M-AnzahlRasterProKilometer;
 hilfsN = N-AnzahlRasterProKilometer;
 
 x = 0.5:1:n-0.5;
 y = 0.5:1:m-0.5;
 
 xi = linspace (min (x), max (x), hilfsN); %Anzahl der Unterteilungen
 yi = linspace (min (y), max (y), hilfsM)'; %Anzahl der Unterteilungen
 hilfsBevMatrix = interp2 (x,y,BevMatrix,xi,yi,"cubic");
 
 xxi = linspace (min (x)-0.5, max (x)+0.5, N); %Anzahl der Unterteilungen
 yyi = linspace (min (y)-0.5, max (y)+0.5, M)'; %Anzahl der Unterteilungen
 
 IntBevMatrix = griddata(xi,yi,hilfsBevMatrix,xxi,yyi,"nearest"); %Extrapolation 
 
 %Normieren damit nicht auf einmal mehr Einwohner entstehen
 sollMenschen = sum(BevMatrix(:))*1^2; % 1^2 da die Fläche ein Kilometer^2 ist.
 istMenschen = sum(IntBevMatrix(:))*h^2;
 quotient= sollMenschen/istMenschen;
 IntBevMatrix = quotient*IntBevMatrix;
 
 
 if(true)
   figure(9990)
   surface (xxi,yyi,IntBevMatrix);
   [x,y] = meshgrid (x,y);
   hold on;
   plot3 (x,y,BevMatrix,"ro");
   title ("Bevoelkerungsdichte Landau");
   ylabel("y")
   xlabel("x")
   colorbar
   hold off;
   if(true)
      filename=["Images/Bevoelkerungsdichte.jpg"];
      saveas(9990, filename)
      close (9990)
    endif
 endif
endfunction
