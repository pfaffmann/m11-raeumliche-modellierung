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
## @deftypefn {} {@var{retval} =} RechenZeit (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-08-17

function strZeit = RechenZeit (EndZeit)
  %Endzeit ist die Zeitdifferenz von cputime zu StartZeit.
  Hundertstelsekunden= num2str(round((EndZeit - floor(EndZeit))*100));
  EndZeit = floor(EndZeit);
  Stunden= floor(EndZeit/3600);
  Minuten= floor((EndZeit-(Stunden*3600))/60);
  Sekunden= EndZeit-(Stunden*3600)-(Minuten*60);
  if(Stunden < 10)
    Stunden = ["0" num2str(Stunden)];
  else
    Stunden = num2str(Stunden);
  endif
  if(Minuten < 10)
    Minuten = ["0" num2str(Minuten)];
  else
    Minuten = num2str(Minuten);
  endif
  if(Sekunden < 10)
    Sekunden = ["0" num2str(Sekunden)];
  else
    Sekunden = num2str(Sekunden);
  endif
  strZeit = [Stunden ":" Minuten ":" Sekunden "." Hundertstelsekunden];
endfunction
