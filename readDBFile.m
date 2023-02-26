% Fuinction readDBFile.m - Reads all data from a file 
% into the Matlab workspace
% Input Argument: The name of the file to read as a string (in single
% quotes)
% For example 'p005r004.csv'
% Return Variables (into the Matlab workspace): (N is the number of
% samples)
% t: timestamp for each sample, in ms (N by 1 vector)
% AcceelroXYZ: X, Y and Z accelerations (N by 3 matrix)
% GyroXYZ: X, Y and Z rotational speeds (N by 3 matrix)
% MagnetoXYZ: X, Y and Z magnetic field readings (N by 3 matrix)
% Stillenss or "Confidence favtor" fpor each sample (N by 1 vector)
% qKalman: Orientation quaternion from internal Kalman F (N by 4 matrix)
%          Columns 1, 2 and 3 are the vector part, column 4 is scalar part
% qTRio : Orientation quaternion from Trio camera system(N by 4 matrix)
%         Columns 1, 2 and 3 are the vector part, column 4 is scalar part
% PosXYZ: X, Y, Z position coordinates for each sample (N by 3 matrix)
% OKTrio: scalar (1 or 0) flag saying if Trio system could track (N by 1)
% label: string with the name of the file being read
function [label,t,Stillness,GyroXYZ,AcceleroXYZ,MagnetoXYZ, qKalman, qTrio, OKTrio, PosXYZ] = readdBFile(FILENAME)

label=FILENAME;
fileID = fopen(FILENAME);
readCell=textscan(fileID,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',',','headerLines',2);
fclose(fileID);

t = readCell{1};
PosXYZ = [readCell{2},readCell{3},readCell{4}];
qTrio= [readCell{5}, readCell{6}, readCell{7}, readCell{8}];
qKalman= [readCell{9}, readCell{10}, readCell{11}, readCell{12}];

GyroXYZ = [readCell{13},readCell{14},readCell{15}];
AcceleroXYZ = [readCell{16},readCell{17},readCell{18}];
MagnetoXYZ = [readCell{19},readCell{20},readCell{21}];
Stillness = readCell{22};
OKTrio = readCell{23};

end

