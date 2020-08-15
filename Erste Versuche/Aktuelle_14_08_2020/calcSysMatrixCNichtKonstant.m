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
## @deftypefn {} {@var{retval} =} calcSysMatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-07-28

function A_h = calcSysMatrixCNichtKonstant (N,M,C,h) % Neumann RB
  %N: Anzahl der Gitterpunkte in x-Richtung
  %M: Anzahl der Gitterpunkte in y-Richtung
  %C: Diffusionskoeffizient Matrix
  %h: Abstand der Gitterpunkte
  
  %-----------------------------------------------------------------------------

  C0 = C(1,:)
  I0 = diag(C0);

  CM = C(M,1)
  IM = diag(CM)
  %-----------------------------------------------------------------------------
  %B_j erstellen
  B_j=zeros(N,N);
  B(1,1)=-1*h*C(j,1);
  B(1,2)=h*C(j,1);
  B(N,N)=-1*h*C(j,N);
  B(N,N-1)=h*C(j,N);
  B(2:N-1,:)=c_ij(C);
  
endfunction
