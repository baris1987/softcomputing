function chrMakeTemplates()

    % Load the images from the training directory
    trainingDir = 'D:/Github/softcomputing/MATLAB/images/Training/';    
    trainingSamples = dir(strcat(trainingDir, '*.png'));
    [numTrainingSamples] = size(trainingSamples);
 	trainingSamplesSize = numTrainingSamples(1,2) * 6;
    in = zeros(60,trainingSamplesSize);
    out = zeros(36,trainingSamplesSize);
    % Create a Pattern Recognition Network
    hiddenLayerSize = 40;
    net = patternnet(hiddenLayerSize);

    % Setup Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

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
        for j=1:6
            % Convert from ASCII character to ASCII int (an index)
            asciiz = uint8(filename(j));
            if (asciiz >= 48 && asciiz <= 57) % number
                asciiz = asciiz - 47;
            elseif (asciiz >= 65 && asciiz <=90) % upper case character
                asciiz = asciiz - 54;
            else
                % We should never, ever get here!
            end

            inVP = sum(chars(:,:,j),2);
            inHP = sum(chars(:,:,j)',2);
            in(:,(i-1)*6+j) = [inVP;inHP];
            out(asciiz,(i-1)*6+j) = 1;
            
            % Update the number of times we have seen this character
            %counts(asciiz) = counts(asciiz) + 1;
        end
    end
   % Train the Network
    [net,tr] = train(net,in,out);

    % Test the Network
    outputs = net(in);
    errors = gsubtract(out,outputs);
    performance = perform(net,out,outputs)

    % View the Network
    view(net)

    % Save them out to the file for later
    save('neuronal.mat', 'net', 'in', 'out');
end