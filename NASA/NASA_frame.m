clc;
%A = imread('C:\Users\44nas\Desktop\NASA/frame-04513.tif');
%image(A)

%============================
%To make smaller just crop smaller pictures very small for
%      accuracy 
%============================

%%%
% set names of query image and target image
%%
%QUERY_IMAGE_NAME='HarryWilliamsCroppedHead.jpg';
%QUERY_IMAGE_NAME='DungyHead.jpg';

%QUERY_IMAGE_NAME='C:\Users\44nas\Desktop\NASA/dark.JPG';


%============================
% Picture that is small and sets the cropping size
% Also is costant comparsio throughout frames
QUERY_IMAGE_NAME='C:\Users\44nas\Desktop\NASA/100.JPG';


arrayOfH = size(100);
count = 1;




%IMAGE_NAME='HarryWilliamsBigCheck.jpg';
%IMAGE_NAME='TonyDungyAward.jpg';
%IMAGE_NAME='C:\Users\44nas\Desktop\NASA/page1.jpg';

%3secTest.mp4
%vid=VideoReader('C:\Users\44nas\Desktop\NASA/20sec.mp4');

%3secTest.mp4


%==========================================================================
% Reads what ever video is in the "( )" below
% Put them into frames 
vid=VideoReader('C:\Users\44nas\Desktop\NASA/3secTest.mp4');
  numFrames = vid.NumberOfFrames;
  n=numFrames;
  
  
% File Folder, will hold the frames
Folder = 'C:\Users\44nas\Desktop/frames20'; 

% File Folder, will hold the the Figures/Finished alterd Frames
FolderFin = 'C:\Users\44nas\Desktop\NASA/frameResults';

% Loops through every 50 frames to accuratly represent one second of time
%
% Anything less would looking at frames that represnt 1/20 -1/30 of a
% second which is not need.
for iFrame = 1:50:n
  frames = read(vid, iFrame);
  imwrite(frames, fullfile(Folder, sprintf('%06d.jpg', iFrame)));
end 
FileList = dir(fullfile(Folder, '*.jpg'));


%==========================================================================



disp("======================VID Filed======================");

for iFile = 1:1:length(FileList)
  aFile = fullfile(Folder, FileList(iFile).name);
  
  %IMAGE_NAME = imread(aFile);

%for frameLoop = 1:100:frameCount
    
    %frame = double(readFrame(v));
    %IMAGE_NAME = frame;
    
    SHOW_CROP_SEARCH= true;

    %I= imread(IMAGE_NAME);
    I = imread(aFile);

    IqOrgnialBig= imread(QUERY_IMAGE_NAME);         %ORGINAL


    CROP_ROWS= size(IqOrgnialBig,1);    %add /8
    CROP_COLS= size(IqOrgnialBig,2);    %add /8



    IMG_ROWS = size(I,1);
    IMG_COLS = size(I,2);

    %%%%%
    % if XSHIFT set to 1 this is pixel by pixel updates
    % if YSHIFT set to 1 this is pixel by pixel updates
    %
    % if XSHIFT set to CROP_COLS this is tesselated along X
    % if YSHIFT set to CROP_COLS this is tesselated along Y
     %%

    %fastest for BasketBall Player
    XSHIFT= 80;
    YSHIFT= 80;

    %fastest for BasketBall Player
    %XSHIFT= 150;
    %YSHIFT= 80;


    %fastest for Pres
    %XSHIFT= 800;
    %YSHIFT= 125;



    % initialize position vector used to display
    % the cropping rectangle
    %
    % [ x y with height]

    pos = [0 0 0 0];
  

    %%%
    % initialize variables used to track the
    % location where cropping achieves its
    % maximum score
    %%

    maxCorrScore= -1000;
    %initialize to large neg value so always find a max
    

    maxXCorr= -1;    %initialize to invalid x-coordinate to make fail stop
    maxYCorr= -1;    %initialize to invalid y-coordinate to make fial stop

 


    currCorrScore= maxCorrScore;  %set in search, but must still intialize
    
    bucketX =[];
    bucketY =[];



    for y=1:YSHIFT:(IMG_ROWS-CROP_ROWS),
       showedMiddle= false;
       for x=120:XSHIFT:(IMG_COLS-CROP_COLS)-120,

          % note the crop window returns region of image one pixel
          % wider and one pixel taller so we specify (CROP_COLS-1)
          % and (CROP_ROWS-1) here so that cropped region is same
          % size as query image

          IcCroped = imcrop(I,[x y ((CROP_COLS-1))  ((CROP_ROWS-1))]); 

          %new
          %if(x2 >= IMG_COLS-CROP_COLS)

           %   x2 = (IMG_ROWS-CROP_ROWS)/2;
            %  IcCroped2 = imcrop(I,[x2 y ((CROP_COLS-1))  ((CROP_ROWS-1))]);
          %else
           %   IcCroped2 = imcrop(I,[x2 y ((CROP_COLS-1))  ((CROP_ROWS-1))]);

          %end    


          %CHANGING PICTURE

        %%
         % to simplify the match score, we will do it with grayscale
         % images instead of color, thus freeing us from having to
         % deal with three color planes (red, green, blue).
        %%
        %IcGrayScale = rgb2gray(Ic);
        %IqGrayScale = rgb2gray(Iq);


        %IcGrayScaleNot = (Ic);
        %IqGrayScaleNot = (Iq);


          if (SHOW_CROP_SEARCH)
            figure(3);
            subplot(2,2,1);
            imshow(IqOrgnialBig);
            subplot(2,2,2);
            continuousHist(IqOrgnialBig);
            subplot(2,2,3);
            imshow(IcCroped)
            subplot(2,2,4);
            continuousHist(IcCroped);

            figure(2);
          
            title('crop window');   



            %update image, can't assume it is clean
            imshow(I,'InitialMagnification','fit');

            pos = [x y CROP_COLS+1 CROP_ROWS+1];

            %set position vector for crop rectangle
            %then draw it on orignal image
            rectangle('Position',pos,'edgecolor','r','linewidth',3);
            title('original image');

            %force display of user interface
            drawnow;


          end





          %disp((IcCroped));
          %imshow(IcCroped)

          %x1 =imread((IcCroped));
          %IcCroped =imresize(x1,[50 50]);  %see your answer in workspace


        %%%
        % compute the correlation match score
        %%

        currCorrScore = myCorrelationMatch(IcCroped, IqOrgnialBig);
        % myCorrelationMatch(imgA, imgB)
    

        %%%
        % If you get a bigger correlaton score, record
        % the (x,y) coordinates of upper left corner
        %%

        
        if (currCorrScore < 0.0 && currCorrScore > -0.05)
          bucketX(count) = x;
          bucketY(count) = y;
          count = count + 1;
        end
        
        

        
        
        
        
        if (currCorrScore > maxCorrScore) 
        
          maxCorrScore= currCorrScore;
          maxXCorr= x;
          maxYCorr= y;
        end
        disp(maxCorrScore+"***************************");
       
       end
    end

    disp('found the best match...');

    pos = [ maxXCorr maxYCorr CROP_COLS CROP_ROWS];
    rectangle('Position',pos,'edgecolor','g','linewidth',.5);
    hold on;
    
   

    fact = 0;
     
    for it=1:1:length(bucketX),
        %imshow(I);
        maxXCorr = bucketX(it);
        maxYCorr = bucketY(it);
        %disp(maxXCorr+"????????");
        %disp(maxXCorr+"????????");
        pos = [ maxXCorr maxYCorr CROP_COLS CROP_ROWS];
        rectangle('Position',pos,'edgecolor','y','linewidth',.5);
        hold on;
       
    end
   
    savefig( fullfile(FolderFin, sprintf('%06d.fig', iFile)));

   

    
    
    
    

    
   
end



for it=1:1:length(FileList),
    openfig(fullfile(FolderFin, sprintf('%06d.fig', it)), 'visible' );
    pause(1.5)
    
end






    disp('done ---------------------------------------------------------');
    
    
    
    
    
    

