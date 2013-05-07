function [retVal] = segment(bounded)
% Performs character segmentation of the preprocessed input image.

% Returns the segmented set of characters.

    % Create the return value (6 images, 30x30 in size)
    retVal = zeros(30, 30, 6);

    % Pass a number from 1 to 6 to each character 
    cc = bwconncomp(bounded);
    labeled = labelmatrix(cc);
  
    charIndex = 1;
    while (charIndex <= 6)
        % Get the position from the pixle of the character
        [yPx,xPx] = find(labeled == charIndex);
        % Create a new empty image with the size of the original
        singleChar = zeros(size(bounded)); 
        % Add only the charater at the given index to the image
        singleChar(labeled == charIndex)= bounded(labeled == charIndex); 
        % Crop the image at the size of the character
        a = imcrop(singleChar, [min(xPx),  min(yPx),  max(xPx) - min(xPx), max(yPx) -  min(yPx)]);
        [charRows, charCols] = size(a);
        % Add the character to a matrix with the size of 30x30
        a = padarray(a, [(30 - charRows) (30 - charCols)], 'post');
        % Store the image in the return value
        retVal(:,:,charIndex) = a;
        charIndex = charIndex + 1;
    end
end