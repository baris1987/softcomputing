function decoded = recognize(imageFileName)

    % Pr�ft ob das Neuronale Netz existiert, falls nicht wird die
    % Generierung angesto�en
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
    % 1. L�dt das Bild und f�hrt das Preprocessing durch
    preprocessed = preprocess(imread(imageFileName));
    
    % 2. Segmentiert das Bild
    segmented = segment(preprocessed);
    
    % 3. Decodiert die Buchstaben
    decoded = classify(segmented);
end