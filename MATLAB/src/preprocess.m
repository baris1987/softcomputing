function bounded = preprocess(i)
% Performs preprocessing on the input image. The image is first converted
% to greyscale and then thresholded. Random noise is removed via
% thresholding. A bounding box is then placed around the entire image.
% Returns the preprocessed image.
%
% Created by Kurt Alfred Kluever (kurt@kloover.com)

    % Convert the color image to grey scale
    greyScale = rgb2gray(i);
    % Threshold out the background noise
    thresholded = greyScale < 75;
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
end