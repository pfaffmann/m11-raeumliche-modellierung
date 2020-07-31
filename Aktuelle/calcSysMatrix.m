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

function A_h = calcSysMatrix (N,M,c,h) % Neumann RB
  %N: Anzahl der Gitterpunkte in x-Richtung
  %M: Anzahl der Gitterpunkte in y-Richtung
  %c: Diffusionskoeffizient konstant
  %h: Abstand der Gitterpunkte
  
  %-----------------------------------------------------------------------------
  % Blockmatrix B erstellen.
  % dim(B) = NxN 
  B = diag(-4*ones(N,1)); %Die Matrix des Aproximationsschema f�r Neumann Randbedingungen hat die Form
  tmp = diag(ones(N-1,1),1);
  B = B + tmp;
  tmp = diag(ones(N-1,1),-1);
  B = B + tmp;
  B(1,1) = -h;
  B(1,2) = h;
  B(N,N) = -h;
  B(N,N-1) = h;
  %-----------------------------------------------------------------------------
  % Blockmatrix I(Schlange) erstellen.
  % dim(I) = NxN
  I = diag(ones(N,1));
  I(1,1) = 0;
  I(N,N) = 0;
  %-----------------------------------------------------------------------------
  % Blockmatrix hI erstellen.
  % dim(hI) = NxN
  hI = h*diag(ones(N,1));
  %-----------------------------------------------------------------------------
  A_h = zeros(N*M,N*M);
  %Erste BlockZeile von A_h anpassen mit -hI und hI
  A_h(1:N,1:N) = -1*hI;
  A_h(1:N,N+1:2*N) = hI;
  %Letzte BlockZeile von A_h anpassen mit -hI und hI
  A_h(((M-1)*N)+1:M*N,((M-1)*N)+1:M*N) = -1*hI;
  A_h(((M-1)*N)+1:M*N,((M-2)*N)+1:(M-1)*N) = hI;
  %Alle Blockzeilen dazwischen anpassen mit B und I
  for i=2:M-1
    A_h((i-1)*N+1:i*N,(i-2)*N+1:(i-1)*N) = I;
    A_h((i-1)*N+1:i*N,(i-1)*N+1:(i-0)*N) = B;
    A_h((i-1)*N+1:i*N,(i-0)*N+1:(i+1)*N) = I;
  endfor
  A_h = (1*c/(h^2))*A_h;
endfunction
