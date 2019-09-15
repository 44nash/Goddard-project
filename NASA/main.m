clear all
close all
v = VideoReader('20sec.mp4');
frameCount = round(v.FrameRate*v.Duration);
c = 0;
for frameLoop = 1:100:frameCount
    c = c+1;
    tic 
    frame = double(readFrame(v));
    frame = frame(:,:,1);
    threshold = 105; %0 to 255
    frame(frame<threshold) = 0;      %black
    frame(~(frame<threshold)) = 255; %white
    i = 0;
    while 1
        i = i+1;
        [a, b] = find(frame == 255);
        if isempty(a)
            break
        end
        [particle, frame] = findParticle(a(1),b(1),frame,[]);
        particle = reshape(particle,2, length(particle)/2);
        cm(:,i) = sum(particle,2)/size(particle,2);
        %disp("CMdemn 1 "+cm(1,:));
        %disp("CMdemn 2 "+cm(2,:));
        %disp('------------------------------------')
        disp(" C ++++++++++++++++++++++++++++++++++++++ "+c);
    end
    if c < 3
        cmX(c,:) = cm(1,:);
        %disp('**************************************')
        %disp("CMXdem1 "+ cmX);
        %disp('**************************************')
        cmY(c,:) = cm(2,:);
        tic
    elseif ( c < 4)  
        a = 12;
        w = c - a;
        u = c - w;
        cmXX(u,:) = cm(1,:);
        
        %disp('**************************************')
        %disp("CMXdem1 "+ cmX);
        %disp('**************************************')
        
        
        cmYY(u,:) = cm(2,:);
        tic
    else
        aa = 13;
        ww = c - aa;
        s = c - ww;
        cmXXX(s,:) = cm(1,:);
        
        %disp('**************************************')
        %disp("CMXdem1 "+ cmX);
        %disp('**************************************')
        
        
        cmYYY(s,:) = cm(2,:);
        tic
    end
    
end




k= 0;
while k < 50

    for i = 1:size(cmX,1)
        clf
        if i < 6
            scatter(cmX(i,:),cmY(i,:),'fill')
            drawnow
            hold on
        elseif ( i < 20) 
            scatter(cmXX(i,:),cmYY(i,:),'fill')
            drawnow
        else
            scatter(cmXXX(i,:),cmYYY(i,:),'fill')
            drawnow
            
        end
    end
    
    k=k+1;
    
    
end 



disp('@@@@@@@@@@@@@@@@@@@done@@@@@@@@@@@@@@@@@@@@@');
