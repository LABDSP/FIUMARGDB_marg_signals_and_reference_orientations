% showDifTrioKF.m - SCRIPT that reads a file and 
% plots
% Components of the quaternion orientation estimate from Trio (qTrio)
% In addition the quaternion components from the on-board Kalman Filter
% orientation estimate are also plotted
% Then the time evolution of the "quaternion difference" (Matlab dif,
% for quaternions is also plotted, with the RMS value of the dif shown.
% The assignment of the database file to be read is defined in the first
% non-comment line. For example:  FILENAME = 'p005r004.csv'
% 
FILENAME = 'rec03.csv';
% - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -
[label,t,Stillness,GyroXYZ,AcceleroXYZ,MagnetoXYZ, qKalman, qTrio, OK, PosXYZ] = readDBFile(FILENAME);
% - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -
N = length(t);          % Detect the number of samples in the file
tsec = t/1000;          % t in seconds
tsend = tsec(N);        % Detect the latency of last sample
% - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -
S1C = [0 0 0 1; 1 0 0 0; 0 1 0 0; 0 0 0 1]'; %Matrix to put scalar first
% Put scalar part of quaternion first for KF and Trio Orientation
% Which is how the matlab commands "quaternion" and "dist" expect them
qKalman1 = qKalman * S1C ;
qTrio1 = qTrio * S1C ;
% Cast the 4-column arrays as sequences of type quaternion in Matlab
qKalman1m =  quaternion(qKalman1);
qTrio1m =  quaternion(qTrio1);
% Now it is possible to compute the series of "quaternion distances"
% which are angles in radians (which can be converted to degrees)
distTKrad = dist(qTrio1m, qKalman1m);
distTKdeg = rad2deg(distTKrad);
rmsvalrad = sqrt(mean( distTKrad .^2));
rmsvaldeg = sqrt(mean( distTKdeg .^2));
% - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -
figure;
subplot(3,1,1);
plot(tsec,qTrio); grid;
axis([0, tsend, -inf, inf]);
title('Quaternion components from Trio Orientation')
%
tx_x = [14 19 33 48 64 81 87 101 117 132];
tx_y = [ 1  1  1  1  1  1  1   1   1   1 ] * 0.45;
%
text(tx_x(1), tx_y(1),'\underline{1}' ,'color', [0,0,1],'Interpreter','latex');
text(tx_x(2), tx_y(2),'\underline{2}' ,'color', [0,0,1],'Interpreter','latex');
text(tx_x(3), tx_y(3),'\underline{3}' ,'color', [0,0,1],'Interpreter','latex');
text(tx_x(4), tx_y(4),'\underline{4}' ,'color', [0,0,1],'Interpreter','latex');
text(tx_x(5), tx_y(5),'\underline{5}' ,'color', [0,0,1],'Interpreter','latex');
text(tx_x(6), tx_y(6),'\underline{6}' ,'color', [1,0,0],'Interpreter','latex');
text(tx_x(7), tx_y(7),'\underline{7}' ,'color', [1,0,0],'Interpreter','latex');
text(tx_x(8), tx_y(8),'\underline{8}' ,'color', [1,0,0],'Interpreter','latex');
text(tx_x(9), tx_y(9),'\underline{9}' ,'color', [1,0,0],'Interpreter','latex');
text(tx_x(10), tx_y(10),'\underline{10}' ,'color', [1,0,0],'Interpreter','latex');
leg = legend('qX','qY','qZ','qW', 'location', 'southwest');
leg.FontSize = 6;

subplot(3,1,2);
plot(tsec,qKalman); grid;
axis([0, tsend, -inf, inf]);
title('Quaternion components from onboard Kalman Filter')
leg = legend('qX','qY','qZ','qW', 'location', 'southwest');
leg.FontSize = 6;

subplot(3,1,3)
plot(tsec,distTKdeg); grid;
axis([0, tsend, 0, inf]);
ylabel('Degrees');
title('Quaternion Distance between orientation estimates from Trio and onboard KF')

xlabel('Time in seconds')