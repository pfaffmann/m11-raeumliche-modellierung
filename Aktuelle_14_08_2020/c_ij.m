## Copyright (C) 2020 Christoph Pfaffmann
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
## @deftypefn {} {@var{retval} =} c (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Christoph Pfaffmann <christoph@Christophs-MBP.fritz.box>
## Created: 2020-08-14

function wert = c_ij (c)

%i - x-Werte - Spalten
%j - y-Werte - Zeilen/Reihen
N=columns(c);
wert=zeros(N-2,N);
i=1;
%c_Links=0;
%c_Rechts=0;
%c_Mitte=0;

for j=2:N-2
i=i+1;


 % if(i==j-1)
    c_Links=0.5*(c(j,i-1)+c(j,i));
 % elseif(i==j+1)
    c_Rechts = 0.5*(c(j,i+1)+c(j,i));
 % elseif(i==j)
 
    c_iPlusHalbJ = 0.5*(c(j,i+1)+c(j,i));
    c_iMinusHalbJ =0.5*(c(j,i-1)+c(j,i));
    c_iJPlusHalb =0.5*(c(j+1,i)+c(j,i));
    c_iJMinusHalb =0.5*(c(j-1,i)+c(j,i));
    c_Mitte = -1*(c_iPlusHalbJ + c_iMinusHalbJ +c_iJPlusHalb +c_iJMinusHalb);
    wert(j,i)=c_Mitte;
    wert(j,i-1)=c_Links;
    wert(j,i+1)=c_Rechts; 
  %endif
  %wert(j,i.+(1:3))=[c_Links c_Mitte c_Rechts];

endfor
endfunction
