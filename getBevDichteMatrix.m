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
## @deftypefn {} {@var{retval} =} getBevDichteMatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-07-10

     %retval = [  329, 262,1330,   3,   4;             
      %          2084,2746,6583,2137,1518;
       %          561, 644,4195,3867,2385;  
        %        1197,1001,1543, 636,2203 ];  

function retval = getBevDichteMatrix ()
  
      retval = [  329, 262,1330,   3,   4;             
                 2084,2746,6583,2137,1518;
                  561, 644,4195,3867,2385;  
                 1197,1001,1543, 636,2203 ];  
endfunction
