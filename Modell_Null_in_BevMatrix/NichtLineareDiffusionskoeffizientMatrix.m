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
## @deftypefn {} {@var{retval} =} NichtLineareDiffusionskoeffizientMatrix (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-08-16

function C = NichtLineareDiffusionskoeffizientMatrix (B, c_0 , k)
 C = atan(k.*B-k/2) + atan(k/2) +c_0;
 %C = NullenAmMatrixRand(C);
 
 if(false)
   figure(9992)
   surface (C);
   title (["Nicht Lineare Diffusionskoeffizient Matrix c_0 = " num2str(c_0) "   k = " num2str(k)]);
   ylabel("y")
   xlabel("x")
   colorbar
   if(false)
      filename=["Images/Nicht_Lineare_Diffusionskoeffizient_ Matrix_ c0_" num2str(c_0) "_k_" num2str(k) ".jpg"];
      saveas(9992, filename)
      close (9992)
    endif
  endif
endfunction
