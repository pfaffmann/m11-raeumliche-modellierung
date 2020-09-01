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
## @deftypefn {} {@var{retval} =} slowdown (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-08-17

function val=slowdown(x)
%Nach den Angegebenen Tagen wird der angegebene Prozentsatz der urspr�nglichen Rate genommen
%Prozentsatz wird durch den Faktor "val" definiert

if x<14 val=1;   
%Zwischen Tag 25 (Tag der Kontaktverbote) und Tag 33 besteht �bergangszeit
%d.h. Menschen, die sich vor den Kontaktverboten infiziert haben, werden dann erst erfasst   
  elseif x<28
  val=0.4; 

 elseif x<33
  val=0.3;
  
%Ersten 10 Tage der Kontaktverbote mit zunaechst weniger einschneidenen Ma�nahmen, darueber hinaus
%haben sich nicht alle Menschen daran gehalten  
  elseif x<42
  val=0.4;
  
%Striktere Ma�nahmen zur Eindaemmung und Umdenken bei der Bevoelkerung  durch Pressemitteilungen aus Italien

  elseif x<69
  val=0.165;

%Weniger aktive Faelle und Weiterfuerhung der Beschraenkungen
  
elseif x<80
  val=0.09;


endif
%Beispielhafte Lockerung der Ma�nahmen ab Tag 80, die die Infektionsrate wieder
%auf 50 % der Basisinfektionsrate erhoeht
%(um den Effekt der Lockerung zu beobachten)
if x>=80 val=0.5; endif
endfunction
