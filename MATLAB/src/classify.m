function [decoded confidence] = classify(chars, method)
% Performs character classification of the segmented input image

    % Load the templates
    load neuronal;

    % Turn off the warnings about dividing by zero
    warning off MATLAB:divideByZero

    % Setup the decoded result
    decoded = char(zeros(1,6));

    % Confidence starts at 1.0 (perfect)
    confidence = 1.0;

    % For each of the 6 characters in the image...
    for i=1:6

        inVP = sum(chars(:,:,i),2);
        inHP = sum(chars(:,:,i)',2);
        res = net([inVP;inHP]);
   
        % Find the first template with the best correlation
        index = find(res == max(res), 1);
        
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