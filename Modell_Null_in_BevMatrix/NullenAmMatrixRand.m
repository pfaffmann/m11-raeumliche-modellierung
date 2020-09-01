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
## @deftypefn {} {@var{retval} =} NullenAmMatrixRand (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: chris <chris@PFAFFMANN-PC>
## Created: 2020-08-16

function Mat_NullenAmRand = NullenAmMatrixRand (Mat)
  M = rows(Mat);
  N = columns(Mat);
  Mat_NullenAmRand = Mat;
  
  Mat_NullenAmRand(1,:)=0;
  Mat_NullenAmRand(M,:)=0;
  Mat_NullenAmRand(:,1)=0;
  Mat_NullenAmRand(:,N)=0;
endfunction
