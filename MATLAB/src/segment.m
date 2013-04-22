function [retVal] = segment(bounded)
% Performs character segmentation of the preprocessed input image.
% Returns the segmented set of characters.
%
% Created by Kurt Alfred Kluever (kurt@kloover.com)

    % Create the return value (5 images, 20x20 in size)
    retVal = zeros(30, 30, 6);
    
    % Get the size of the input image
    [rows cols] = size(bounded);
    
    col=3;
    startCol = 1;
    charIndex = 1;
    
    % While we aren't at the end of the image...
    while(col < cols)
        col = col + 10;
        % Scan forward while columns contain data
        while (col+2 <= cols) && (sum(sum(bounded(:,col:col+2))) > 0)
            col = col + 1;
        end
        
        % Crop the character out of the image
        a = imcrop(bounded, [startCol 1 (col - startCol) rows]);
        
        % Pad out to 20 rows and 20 cols with 0's
        [charRows charCols] = size(a);
        a = padarray(a, [(30 - charRows) (30 - charCols)], 'post');
              
        % Set the character into the return value
        retVal(:,:,charIndex) = a;
        
        % Increment the characters index
        charIndex = charIndex + 1;
        
        % Increment the column counter
        col = col + 1;
        startCol = col;
        
        % Advance the column counter while there is white space
        while (col <= cols) && (sum(sum(bounded(:,col))) == 0)
            col = col + 1;
            startCol = startCol + 1;
        end
    end
end