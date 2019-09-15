function score = myCorrelationMatch(imgA, imgB)
%
%  write your correlation implementation
%
%  NO you cannot use MATLAB's correlation routine
%  the call to corr(.) is here as a benchmark
%  to show you this does really work
%
%  you may not use MATLAB's builtin routines
%  you must implement everything yourself.
%

[ROWS, COLS] = size(imgA);
disp([ROWS, COLS]);

aVec = double(reshape(imgA,ROWS*COLS,1));
bVec = double(reshape(imgB,ROWS*COLS,1));

%disp(" aVec " +aVec);
%disp(" bVec "+bVec);
aVecSize = size(aVec,1);
bVecSize = size(bVec,1);
%disp(aVecSize);
ATotal = sum(aVec);
BTotal = sum(bVec);
aMean = ATotal/ aVecSize;
bMean = BTotal/ bVecSize;
c = 0;
for i=1:1:aVecSize
    a= aVec(i)-aMean;
    b= bVec(i)-bMean;
    c= (a*b)+c;
end
CovXY = c/(aVecSize-1);

sum2 = 0;
for i=1:1:aVecSize
    sum2 = (power((aVec(i) - aMean),2))+sum2;
end
SampleVar = sum2/aVecSize -1;
SDA = realsqrt(SampleVar);

sum2 = 0;
for i=1:1:bVecSize
    sum2 = (power((bVec(i) - bMean),2))+sum2;
end
SampleVar = sum2/bVecSize -1;
%disp(SampleVar);
SDB = realsqrt(SampleVar);

rho2 = CovXY/(SDA*SDB);

rho = corr(aVec,bVec);


%disp("Value of Rho ---- "+rho +" &&& " +"Value of Rho2 ---- "+rho2);
%disp("   ");

score = rho2;
end