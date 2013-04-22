function [decoded confidence] = classify(chars, method)
% Performs character classification of the segmented input image using
% pixel counts, vertical projections, horizontal projections, or template
% matching.
% Returns the classified string of characters and the confidence.
%
% Created by Kurt Alfred Kluever (kurt@kloover.com)

    % Load the templates
    load templates;

    % Turn off the warnings about dividing by zero
    warning off MATLAB:divideByZero

    % Setup the decoded result
    decoded = char(zeros(1,6));

    % Confidence starts at 1.0 (perfect)
    confidence = 1.0;

    % For each of the 5 characters in the image...
    for i=1:6

        % Correlation results for all the template images
        allCorrs = zeros(1, 36);
        
        % For each of the templates...
        for j=1:36
            if (strcmp(method, 'PixelCounts') == 1)
                % Note that we subtract it from 50 so that we can still
                % use max() to find the correct index below!
                tempSum = sum(sum(templates(:,:,j)));
                inSum = sum(sum(chars(:,:,i)));
                allCorrs(j) = 50 - abs(tempSum - inSum);
            elseif (strcmp(method, 'VerticalProjections') == 1)
                tempVP = sum(templates(:,:,j));
                inVP = sum(chars(:,:,i));
                allCorrs(j) = corr2(tempVP, inVP);
            elseif (strcmp(method, 'HorizontalProjections') == 1)
                tempHP = sum(templates(:,:,j)');
                inHP = sum(chars(:,:,i)');
                allCorrs(j) = corr2(tempHP, inHP);
            else % Do template matching by default
                temp = templates(:,:,j);
                in = chars(:,:,i);
                allCorrs(j) = corr2(temp, in);
            end
        end

        % Find the first template with the best correlation
        index = find(allCorrs == max(allCorrs), 1);
        
        % Update the classification confidence
        confidence = max(allCorrs) * confidence;

        % Convert it from an index back into ASCII
        if (index <= 10) % number
            index = index + 47;
        elseif (index >= 11 && index <= 36)% upper case character
            index = index + 54;
        else
            % We should never get here
        end
        
        % Store the decoded character
        decoded(i) = char(index);
    end
end