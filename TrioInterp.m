% TrioInterp Function that lin. interpolates Trio quaternions or positions
% Whenever "IsTracked" took on a value of 0
%
% SYNTAX: QOUTS = TrioInterp(QINS, IsT)
%
function QOUTS = TrioInterp(QINS, IsT)
[r,c] = size(IsT);
dIsT = diff(IsT);

[ONi,ONv]= find(IsT == 1);
ONirev = flipud(ONi);
firstON = ONi(1);
lastON = ONirev(1);
lenIsT = length(IsT);

status = sprintf('Firts ON is %d  ; Last ON is %d  ; LenIsT is %d',firstON, lastON, lenIsT);
% disp(status);


 [Ib,vb] = find(dIsT == (-1));
 [Iee,vee] = find(dIsT == 1); 
 Ie = Iee +1;

QOUTS = QINS;   % default, unchanged

 LenIb = length(Ib);

    for k = 1:LenIb
        gap = QINS( Ib(k): Ie(k) , : );
        gapout = gap;
        lengap = Ie(k) - Ib(k) + 1;
        deltaq = ( gap(lengap,:) - gap(1,:) ) / (lengap-1);
            for s = 1:(lengap-1)
                gapout(s+1,:)= gapout(s,:) + deltaq;
            end
        QOUTS( Ib(k): Ie(k) , : ) = gapout;
    end
end