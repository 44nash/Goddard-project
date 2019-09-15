function continuousHist(imgRGB)
RED= 1;
GREEN=2;
BLUE= 3;
NUM_BINS=256;

[ROWS, COLS, DEPTH] = size(imgRGB);

redChan= imgRGB(:,:,RED);
greenChan= imgRGB(:,:,GREEN);
blueChan= imgRGB(:,:,BLUE);

[yRedChan, xRed]= imhist(redChan,NUM_BINS);
[yGreenChan, xGreen]= imhist(greenChan,NUM_BINS);
[yBlueChan, xBlue] = imhist(blueChan,NUM_BINS);

plot(xRed,yRedChan,'Red',xGreen,yGreenChan,'Green',xBlue,yBlueChan,'Blue');
th2 = title('b) wide angle color histogram');
xp= get(th2,'position');
xp(2)= xp(2)-26*ROWS;
set(th2,'position',xp);

return