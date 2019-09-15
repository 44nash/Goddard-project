FolderFin = 'C:\Users\44nas\Desktop\NASA/frameResults';
for it=1:1:length(3),
    %disp(arrayOfH(it));
    %figure(700);
    %imshow(I,'InitialMagnification','fit');
    openfig(fullfile(FolderFin, sprintf('%06d.fig', it)), 'visible' );
    %disp(fileID);
    %openfig(fileID,'visible')

    %imshow(fileID,'RESULTS_MOVIE','fit');
    %imshow(fileID);
    pause(1.5)
    
end

%above code is a Success