clear all
close all

v = VideoReader('Q1Stars.mp4');
%for frameLoop = 1:1000:(v.FrameRate*v.Duration)
for frameLoop = 1:10:(100)
    frame = double(readFrame(v));
    frame = frame(:,:,1);
    threshold = 85.0;
    frame(frame < threshold) =  0;     % Black
    frame(~(frame < threshold)) = 255; % White
    imshow((frame))
    %particle positions are black
    i = 0;
    while 1
        i = i+1;
        [a, b]= find(frame == 255);
        if isempty(a)
            break
        end
        [particle, frame] = findParticle(a(1), b(1), frame,[]);
        particle = reshape(particle, 2, length(particle)/2);
        cm(:, i) = sum(particle,2)/size(particle,2);

    end
    cmX(frameLoop,:) = cm(1,:);
    cmY(frameLoop,:) = cm(2,:);
    imshow(readFrame(v))
    hold on
    scatter(cm(2,:), cm(1,:), 'fill')
    
    
end   
    
    
    
    
    
    
    
    
    
    
    