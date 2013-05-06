function decoded = recognize(imageFileName)

    % If the templates haven't been created yet, make them now!
    if (exist('neuronal.mat', 'file') == 0)
        fprintf('Training templates do not exist. Creating them now...');
        buildNetwork();
        fprintf('DONE\n');
    end
    
    % 1. Load and preprocess the image
    preprocessed = preprocess(imread(imageFileName));
    
    % 2. Segmentation the image into characters
    segmented = segment(preprocessed);
    
    % 3. Classifiy the characters
    decoded = classify(segmented);
end