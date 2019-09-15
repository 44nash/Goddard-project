% Folder = 'I:\testing\abrupt\';
vid=VideoReader('C:\Users\44nas\Desktop\NASA/20sec.mp4');
  numFrames = vid.NumberOfFrames;
  n=numFrames;
Folder = 'C:\Users\44nas\Desktop/frames20';
for iFrame = 1:n
  frames = read(vid, iFrame);
  imwrite(frames, fullfile(Folder, sprintf('%06d.png', iFrame)));
end 
FileList = dir(fullfile(Folder, '*.png'));
for iFile = 1:length(FileList)
  aFile = fullfile(Folder, FileList(iFile).name);
  img   = imread(aFile);
end
disp('DONE')