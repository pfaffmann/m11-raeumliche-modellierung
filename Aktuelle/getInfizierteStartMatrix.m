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
## @deftypefn {} {@var{retval} =} getInfizierteStartMatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-07-28

function infizierteStartMatrix = getInfizierteStartMatrix (N,M,h)
  
 mitteX = floor(N/2);
 mitteY = floor(M/2);
 radius = 2;
 X=mitteX-radius:1:mitteX+radius;
 Y=mitteY-radius:1:mitteY+radius;
 infizierteStartMatrix = zeros(M,N);
 infizierteStartMatrix(Y,X) = 1/(25*h^2);   %Sollte 1 Infizierter auf 1km^2 sein, da 25*100*100m^2 0,25 infiziert sind.

endfunction
