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
## @deftypefn {} {@var{retval} =} newSysMatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-08-16

function A_h = newSysMatrix (M,N,h,C)
%clear all;
%close all;
%C=ones(260,260).*0.03;
%h=1;
%for i=1:columns(C)
%  C(i,i)=0;
%endfor

% N=columns(C);     %Index i
% M=rows(C);        %Index j
  
  %-----------------------------------------------------------------------------
  %B erstellen
   B=zeros(N,N);
   IDach1=zeros(N,N);
   IDach2=zeros(N,N);
   A_h=zeros(N*M,N*M);
  %Laufe in einer Zeile alle Spalten durch 

  %-----------------------------------------------------------------------------
  %Erstellung der Blöcke für die erste Blockzeile
  C0 = C(1,:);
  I0 = diag(C0);
  A_h(1:N,1:N)=-h.*I0;
  A_h(1:N,N+1:2*N)=h.*I0;

  CM = C(M,:);
  IM = diag(CM);
  A_h(end-N+1:end,end-N+1:end)=-h.*IM;
  A_h(end-N+1:end,end-2*N+1:end-N)=h.*IM;
  %-----------------------------------------------------------------------------
for j=2:M-1

for i=1:N
  %Die Erstellung klappt eigentlich - der Einbau schlaegt fehl!
  if(i==1)  
  B(1,1)=-1*h*C(j,1);
  B(1,2)=h*C(j,1);
  

  elseif(i==N)
  B(N,N)=-1*h*C(j,N);
  B(N,N-1)=h*C(j,N);
 
 elseif(i>1&&i<N)

    c_iPlusHalbJ   = 0.5*(C(j,i+1)+C(j,i));
    c_iMinusHalbJ  = 0.5*(C(j,i-1)+C(j,i));
    c_iJPlusHalb   = 0.5*(C(j+1,i)+C(j,i)); 
    c_iJMinusHalb  = 0.5*(C(j-1,i)+C(j,i));
    c_Mitte = -1*(c_iPlusHalbJ + c_iMinusHalbJ +c_iJPlusHalb +c_iJMinusHalb);
    B(i,i)=c_Mitte;
    
    c_Links=0.5*(C(j,i-1)+C(j,i));
    B(i,i-1)=c_Links;
    
    c_Rechts = 0.5*(C(j,i+1)+C(j,i));
    B(i,i+1)=c_Rechts;
    
    %IDach hier raus!
    IDach1(i,i)=0.5*(C(j-1,i)+C(j,i));
    
    IDach2(i,i)=0.5*(C(j+1,i)+C(j,i));
    
    
 endif

A_h((N*(j-1))+1:N*j,(N*(j-1))+1:N*j)=B;
A_h((N*(j-1))+1:N*j,(N*(j-2))+1:N*(j-1))=IDach1;
A_h((N*(j-1))+1:N*j,N*j+1:N*(j+1))=IDach2;
endfor
endfor
%figure(1)
%spy(A_h)

%A_h(1:N,1:N)=...;
%A_h(1:N,(N+1):(2*N))=...;
A_h=-1/(h^2*1000)*A_h;
%----------------------------------------
endfunction
