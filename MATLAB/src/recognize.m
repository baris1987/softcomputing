function decoded = recognize(imageFileName)
% Performs recognition of PayPal CAPTCHA images by preprocessing,
% segmentation, and classification. To switch which classifier is being
% used, simply uncomment out the one you wish to use!
%
% Created by Kurt Alfred Kluever (kurt@kloover.com)

    % If the templates haven't been created yet, make them now!
    if (exist('neuronal.mat', 'file') == 0)
        fprintf('Training templates do not exist. Creating them now...');
        chrMakeTemplates();
        fprintf('DONE\n');
    end
    
    % 1. Load and preprocess the image
    preprocessed = preprocess(imread(imageFileName));
    
    % 2. Segmentation the image into characters
    segmented = segment(preprocessed);
    
    % 3. Classifiy the characters
    decoded = classify(segmented);
end