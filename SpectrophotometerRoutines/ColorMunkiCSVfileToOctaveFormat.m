function [Wavelengths, Reflectances] = ColorMunkiCSVfileToOctaveFormat(ColorMunkiCSVfile);
% Purpose		Convert the information in a comma-separated file, generated from a ColorMunki Design
%				spectrophotometer, into vectors and matrices in Octave/Matlab format.
%
% Description	The ColorMunki Design measures the reflectance spectrum of a colour sample. The
%				data for a set of colour samples can be exported to a comma-separated (.csv) file,
%				by using the File/Export command and choosing the option 'Comma Separated.'  This
%				routine converts the information in such a CSV file into Octave/Matlab format.  The
%				Octave/Matlab format consists of a vector of wavelengths, and another vector of the
%				same length, each entry of which is the reflectance percentage for the corresponding
%				wavelength.
%
% Syntax		[Wavelengths, Reflectances] = ColorMunkiCSVfileToColourInfo(ColorMunkiCSVfile);
%
%				ColorMunkiCSVfile	Comma-separated file produced using Export command of
%									ColorMunki Design
%
%				Wavelengths			A row vector whose entries are the wavelengths for the reflectance  
%									spectra of the colour samples exported from a ColorMunki Design
%
%				Reflectances		A matrix, whose rows are the reflectances (expressed as values 
%									between 0 and 1) for the reflectance spectra of the 
%									colour samples exported from a ColorMunki Design
%
% Author		Paul Centore (May 19, 2012)
% Revision		Paul Centore (August 31, 2013)  
%				 ---Moved from MunsellToolbox program to MunsellAndKubelkaMunkToolbox.
%
% Copyright 2012 Paul Centore
%
%    This file is part of MunsellAndKubelkaMunkToolbox.
%
%    MunsellAndKubelkaMunkToolbox is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    MunsellAndKubelkaMunkToolbox is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with MunsellAndKubelkaMunkToolbox.  If not, see <http://www.gnu.org/licenses/>.

% Open the CSV file generated by the ColorMunki Design
fid  = fopen(ColorMunkiCSVfile, 'r')		;

% Read the file into a matrix; strings in the file will not appear as strings, but
% numbers will be preserved.
AllFileData = dlmread(fid, ',')				;
[row, col] = size(AllFileData)				;

% The first row of the file is a header row.  The first four entries of the header
% row are Name, L*, a*, and b*.  The remainder of the header row is a list of 
% wavelengths at which reflectances are measured.  Extract these wavelengths.
Wavelengths = AllFileData(1, 5:col)			;

% Every row of the file except the first is data for one colour sample.  The first
% four entries of each row are a name, an L* value, an a* value, and a b* value.  The
% remaining entries are the reflectances for the wavelengths listed in the first row.
Reflectances = AllFileData(2:row, 5:col)	;

fclose(fid)									;