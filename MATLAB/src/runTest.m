function[charAcc, capAcc] = recognizeAll()

    testingDir = '../images/Test/';
    % Prüft ob das Neuronale Netz existiert, falls nicht wird die
    % Generierung angestoßen
    if (exist('neuronal.mat', 'file') == 0)
        fprintf('Neuronales Netz existiert nicht und wird jetzt generiert ...\n');
        trainPerf = 1;
        trainCount = 0;
        while(trainPerf > 0.002 && trainCount < 5)
            fprintf('%d. Generierung wird gestartet ...\n', trainCount+1);
            [net, training] = buildNetwork();
            if(trainPerf > training.best_perf)
                trainPerf = training.best_perf;
                save('neuronal.mat', 'net');
            end
            trainCount = trainCount + 1;
        end
    
        fprintf('Fertig (Trainingsperformance: %f)\n', trainPerf);
    end

    % Zählt die Anzahl der vorhanden Bilder des Verzeichnises
    testingSamples = dir(strcat(testingDir, '*.png'));
    numTestingSamples = size(testingSamples, 1);
    
    charCorrect = 0;
    charWrong = 0;
    captureWrong = 0;

    for i=1:numTestingSamples
        
        filename =  testingSamples(i).name;
        % Übergibt das Bild der recognize Funktion und erhält die vom
        % Neuronalen Netz erkannten Buchstaben zurück
        chars = recognize(strcat(testingDir,filename));
        filename = strrep(filename, '.png', '');
       
        
       fprintf('%d\t Aktuell: %s\t Erkannt: %s\t', i, filename, chars);
       % Prüft komplettes Captcha auf Übereinstimmung
       if (strcmp(filename, chars) == 0)
           fprintf(' NOK\n');
           captureWrong = captureWrong + 1;
       else
           fprintf(' OK\n');
       end
       % Prüft einzellne Buchstaben auf Übereinstimmung
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
