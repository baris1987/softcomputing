function[charAcc, capAcc] = recognizeAll()

    testingDir = '../images/Test/';
    
    if (exist('neuronal.mat', 'file') == 0)
        fprintf('Training templates do not exist. Creating them now...');
        buildNetwork();
        fprintf('DONE\n');
    end

    testingSamples = dir(strcat(testingDir, '*.png'));

    numTestingSamples = size(testingSamples, 1);
    
    charCorrect = 0;
    charWrong = 0;
    captureWrong = 0;
    
    % For each of the testing images...
    for i=1:numTestingSamples
        
        filename = strcat(testingDir, testingSamples(i).name);  
        % Remove the directory name from the filename
        filename = strrep(filename, testingDir, '');
               
       % Perform recognition and record the result and confidence
       chars = recognize(filename);
       
     
       filename = strrep(filename, testingDir, '');
       filename = strrep(filename, '.png', '');
       
       % Print out the results
       fprintf('%d Actual: %s Decoded: %s', i, filename, chars);
       if (strcmp(filename, chars) == 0)
           fprintf(' Incorrect\n');
           captureWrong = captureWrong + 1;
       else
           fprintf(' Correct\n');
       end
       
       for j=1:6
          if (strcmp(filename(j), chars(j)) == 0) 
              charWrong = charWrong + 1;
          else
              charCorrect = charCorrect + 1;
          end
       end   
    end
       
    charAcc = charCorrect / (charCorrect + charWrong);
    capAcc = (numTestingSamples - captureWrong) / numTestingSamples;
    fprintf('Character Accuracy: %f\n', charAcc);
    fprintf('Captcha Accuracy: %f\n', capAcc);
end
