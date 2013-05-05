function makeTemplates()
% Creates the classification templates using a set of training images. The
% training images are labeled as ground truth by their filenames.
%
% Created by Kurt Alfred Kluever (kurt@kloover.com)

    % Set aside room for the templates and the counts
    templates = zeros(20,20,36);
    counts = zeros(1,36);

    % Load the images from the training directory
    trainingDir = 'training/';    
    trainingSamples = dir(strcat(trainingDir, '*.png'));
    [numTrainingSamples] = size(trainingSamples);
    net = patternnet(10);
    % For each of the training images...
    for i=1:numTrainingSamples
        filename = strcat(trainingDir, trainingSamples(i).name);  

        % Perform preprocessing
        bounded = preprocess(imread(filename));     

        % Perform segmentation
        chars = segment(bounded);

        % Remove the directory name from the filename
        filename = strrep(filename, trainingDir, '');
        
        % For each of the characters...
        for i=1:5
            % Convert from ASCII character to ASCII int (an index)
            asciiz = uint8(filename(i));
            if (asciiz >= 48 && asciiz <= 57) % number
                asciiz = asciiz - 47;
            elseif (asciiz >= 65 && asciiz <=90) % upper case character
                asciiz = asciiz - 54;
            else
                % We should never, ever get here!
            end
            
            net = train(net,chars(:,:,i),asciiz);
            % Add the template to the training library
            %templates(:,:,asciiz) = templates(:,:,asciiz) + chars(:,:,i);

            % Update the number of times we have seen this character
            %counts(asciiz) = counts(asciiz) + 1;
        end
    end
    
    % Go through and normalize (average) the templates
    %for i=1:36
    %    templates(:,:,i) = templates(:,:,i) / counts(i);
    %end
    
    % Save them out to the file for later
    %save('templates.mat', 'templates', 'counts');
    save('neuronal.mat', 'net');
end