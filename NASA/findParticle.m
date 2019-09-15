function [particle, frame] = findParticle(curRow,curCol,frame,particle)
if curRow == 0 || curRow == size(frame,1) || curCol == 0 || curCol == size(frame,2)
    return 
end
if ~frame(curRow,curCol)
    return
end
particle = [particle curRow curCol];
frame(curRow,curCol) = 0;
[particle, frame] = findParticle(curRow+1,curCol,frame,particle);
[particle, frame] = findParticle(curRow-1,curCol,frame,particle);
[particle, frame] = findParticle(curRow,curCol+1,frame,particle);
[particle, frame] = findParticle(curRow,curCol-1,frame,particle);