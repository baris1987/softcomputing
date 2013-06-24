function[charAcc, capAcc] = runTest()
    testingDir = '../images/Test/';    
    testingSamples = dir(strcat(testingDir, '*.png'));
    numTestingSamples = size(testingSamples, 1);
    charCorrect = 0;
    charWrong = 0;
    captureWrong = 0;
    for i=1:numTestingSamples
        filename =  testingSamples(i).name;
        % Ruft die Recognize Funktion auf und bekommt die erkannten Zeichen zurueck
        chars = recognize(strcat(testingDir,filename));
        filename = strrep(filename, '.png', '');
        fprintf('%d\t Aktuell: %s\t Erkannt: %s\t', i, filename, chars);
        % Prueft komplettes Captcha auf Uebereinstimmung
        if (strcmp(filename, chars) == 0)
           fprintf(' NOK\n');
           captureWrong = captureWrong + 1;
        else
           fprintf(' OK\n');
        end
        % Prueft die einzelnen Zeichen auf Uebereinstimmung
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
     fprintf('Buchstaben Erkennungsrate: %f\n', charAcc);
     fprintf('Captcha Erkennungsrate: %f\n', capAcc);
end