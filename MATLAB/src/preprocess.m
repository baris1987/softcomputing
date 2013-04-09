function bounded = preprocess(i)
% Performs preprocessing on the input image. The image is first converted
% to greyscale and then thresholded. Random noise is removed via
% thresholding. A bounding box is then placed around the entire image.
% Returns the preprocessed image.
%
% Created by Kurt Alfred Kluever (kurt@kloover.com)


  
    % Bild in Graustufen umwandeln
    greyScale = rgb2gray(i);
    % Alle vorhandenen Farben auflisten
    imageColors = unique(greyScale(:));
    % Der Hintergrund interessiert nicht, deshalb wird die Farbe aus der
    % Liste gelöscht
    imageColors = imageColors(imageColors~=255);
    % Zählen wie oft die einzellnen Farben vorkommen
    colorCounts = histc(greyScale, imageColors);
    sumRow = sum(colorCounts,2);
    
    % Das maximum sollte nun hoffentlich der Textfarbe entsprechen
    [maxNum, maxInd] = max(sumRow);
    txt_color = imageColors(maxInd);
      
    subplot(4,1,2);
    imshow(greyScale);
    title('After rgb2gray');
    % Nur noch die Textfrabe wird angezeigt
    thresholded = greyScale == txt_color;
    subplot(4,1,3);
    imshow(thresholded);
    title('After cleaning');
    % Remove any random noise that will hurt the char offset
    rows = size(thresholded, 1);
    row = 1;
    while (row < rows)
        rowSum = sum(thresholded(row,:));
        if (rowSum < 5 && rowSum > 0)
           thresholded(row,:) = 0;
        end
        row = row + 1;
    end
    
    % Place a bounding box around the image
    bb = regionprops(double(thresholded), 'BoundingBox');

    % Crop out the contents of the bounding box
    bounded = imcrop(thresholded, bb.BoundingBox);
    subplot(4,1,4);
    imshow(bounded);
    title('After cutting');
end