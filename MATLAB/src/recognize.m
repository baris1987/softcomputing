function decoded = recognize(imageFileName)

    % Prüft ob das Neuronale Netz existiert, falls nicht wird die
    % Generierung angestoßen
    if (exist('neuronal.mat', 'file') == 0)
        fprintf('Neuronales Netz existiert nicht und wird jetzt generiert ...');
        buildNetwork();
        fprintf('Fertig\n');
    end
    
    % 1. Lädt das Bild und führt das Preprocessing durch
    preprocessed = preprocess(imread(imageFileName));
    
    % 2. Segmentiert das Bild
    segmented = segment(preprocessed);
    
    % 3. Decodiert die Buchstaben
    decoded = classify(segmented);
end