function [net, training] = buildNetwork()

    trainingDir = '../images/Training/';
    trainingSamples = dir(strcat(trainingDir, '*.png'));
    [numTrainingSamples] = size(trainingSamples);
    trainingSamplesSize = numTrainingSamples(1,1) * 6;
    in = zeros(60,trainingSamplesSize);
    out = zeros(36,trainingSamplesSize);
    
    % Erstellt ein Pattern Recognition Netzwerk
    net = patternnet(38);
    net.divideParam.valRatio = 0;
    net.divideFcn = 'dividerand';
    net.divideMode = 'sample';
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    net.trainParam.goal = 0.0001;
    net.performFcn='msereg'; 
  
    for i=1:numTrainingSamples
        filename = strcat(trainingDir, trainingSamples(i).name);  
        bounded = preprocess(imread(filename));     
        chars = segment(bounded);
        % Ordnerpfad von Dateinamen entfernen
        filename = strrep(filename, trainingDir, '');
        for j=1:6
            % Konvertiert von ASCII zu int 
            % Zahlen liegen nachher im Bereich 1 - 10
            % Buchstaben liegen im Bereich 11 - 36
            asciiz = uint8(filename(j));
            if (asciiz >= 48 && asciiz <= 57)
                asciiz = asciiz - 47;
            elseif (asciiz >= 65 && asciiz <= 90)
                asciiz = asciiz - 54;
            end
            % Summiert die Anzahl der Horizontalen und Vertikalen Pixel
            inVP = sum(chars(:,:,j),2);
            inHP = sum(chars(:,:,j)',2);
            % Speichert die berechneten Matizen in den Input des Neuronalen
            % Netzes und den Buchstabenwert in den Output
            in(:,(i-1)*6+j) = [inVP;inHP];
            out(asciiz,(i-1)*6+j) = 1;
        end
    end
    % Trainiert das Netzwerk
    [net, training] = train(net,in,out);       
end
