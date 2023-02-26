% showMARGSignals.m - SCRIPT that 
% reads a file and plots the accelerometer, magnetometer and gyroscope
% signals in the file. - For reference, the quaternion components from 
% the Trio system ar also plotted.
% The assignment of eth database file to be read is defined in the first
% non-comment line. For example:  FILENAME = 'p005r004.csv'
% 
FILENAME = 'rec03.csv';
% - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -
[label,t,Stillness,GyroXYZ,AcceleroXYZ,MagnetoXYZ, qKalman, qTrio, OK, PosXYZ] = readDBFile(FILENAME);
% - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -
N = length(t);          % Detect the number of samples in the file
tsec = t/1000;           % t in seconds
tsend = tsec(N);        % Detect the latency of last sample
% - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -
figure;
subplot(4,1,1);
plot(tsec,AcceleroXYZ); grid;
axis([0, tsend, -inf, inf]);
title('Accelerometer Channels')
ylabel('Mult. of 9.81 m/s2')
leg = legend('Accel X', 'Accel Y','Accel Z', 'location', 'southwest');
leg.FontSize = 6;
subplot(4,1,2);
plot(tsec,GyroXYZ); grid;
axis([0, tsend, -inf, inf]);
title('Gyroscope Channels')
ylabel('rad / s')
leg = legend('Gyro X', 'Gyro Y','Gyro Z', 'location', 'southwest');
leg.FontSize = 6;
subplot(4,1,3);
plot(tsec,MagnetoXYZ); grid;
ylabel('Gauss')
axis([0, tsend, -inf, inf]);
title('Magnetometer Channels')
leg = legend('Magnet X', 'Magnet Y','Magnet Z', 'location', 'southwest');
leg.FontSize = 6;
subplot(4,1,4);
plot(tsec,qTrio); grid;
axis([0, tsend, -inf, inf]);
title('Quaternion components from Trio Orientation')
leg = legend('qX','qY','qZ','qW', 'location', 'southwest');
leg.FontSize = 6;
xlabel(' time in seconds')
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
