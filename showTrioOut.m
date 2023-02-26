% showTrioOut.m - SCRIPT that reads a file and 
% plots outputs from the Trio camera system:
% Position coordinates (px, py, pz) of center of rigid body triangle
% Components of the quaternion orientation estimate from Trio (qTrio)
% Flag that goes to zero if at least one marker was undetectable
% In addition the quaternion components from the on-board Kalman Filter
% orientation estimate are also plotted
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
figure;
subplot(4,1,1);
plot(tsec,PosXYZ); grid;
axis([0, tsend, -inf, inf]);
title('Position Coordinates')
ylabel('meters')
leg = legend('Pos X', 'Pos Y','Pos Z', 'location', 'southwest','NumColumns',2);
leg.FontSize = 6;
subplot(4,1,2);
plot(tsec,qTrio); grid;
axis([0, tsend, -inf, inf]);
leg = legend('qX','qY','qZ','qW', 'location', 'southwest');
leg.FontSize = 6;
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

subplot(4,1,3);
plot(tsec,OK);hold on
plot(tsec,OK, 'rx');grid on
axis([0, tsend, -inf, inf]);
title('Trio OK flag: 1 = normal, 0 = marker(s) undetectable')
subplot(4,1,4);
plot(tsec,qKalman); grid;
axis([0, tsend, -inf, inf]);
title('Quaternion components from onboard Kalman Filter')
leg = legend('qX','qY','qZ','qW', 'location', 'southwest','NumColumns',2);
leg.FontSize = 6;
xlabel('Time in seconds')