function bounded = preprocess(i)
% Performs preprocessing on the input image. The image is first converted
% to greyscale and then thresholded. Random noise is removed via
% thresholding. A bounding box is then placed around the entire image.
% Returns the preprocessed image.
%
% Created by Kurt Alfred Kluever (kurt@kloover.com)


  
    % Bild in Graustufen umwandeln
    greyScale = rgb2gray(i);
    subplot(4,1,2);
    imshow(greyScale);
    title('After rgb2gray');
    % Nur noch die Textfrabe wird angezeigt
    thresholded = greyScale < 65;
    subplot(4,1,3);
    imshow(thresholded);
    title('After cleaning');

    
  
    % Place a bounding box around the image
    bb = regionprops(double(thresholded), 'BoundingBox');

    % Crop out the contents of the bounding box
    bounded = imcrop(thresholded, bb.BoundingBox);
    subplot(4,1,4);
    imshow(bounded);
    title('After cutting');
end