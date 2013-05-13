
function buildNetwork()

    trainingDir = '../images/Training/';
    trainingSamples = dir(strcat(trainingDir, '*.png'));
    [numTrainingSamples] = size(trainingSamples);
 	trainingSamplesSize = numTrainingSamples(1,1) * 6;
    in = zeros(60,trainingSamplesSize);
    out = zeros(36,trainingSamplesSize);
    % Create a Pattern Recognition Network
    hiddenLayerSize = 38;
    net = patternnet(hiddenLayerSize);

    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

  
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
            % asciiz zwischen 48 und 57 -> Zahl
            if (asciiz >= 48 && asciiz <= 57)
                asciiz = asciiz - 47;
            % asciiz zwischen 65 und 90 -> Zahl
            elseif (asciiz >= 65 && asciiz <= 90)
                asciiz = asciiz - 54;
            end
            
            % Summiert die Anzahl der Horizontalen und Vertikalen Pixel
            inVP = sum(chars(:,:,j),2);
            inHP = sum(chars(:,:,j)',2);
            % Speichert die berechneten Matixen in den Input des Neuronalen
            % Netzes und den Buchstabenwert in den Output
            in(:,(i-1)*6+j) = [inVP;inHP];
            out(asciiz,(i-1)*6+j) = 1;
        end
    end
    % Trainiert das Netzwerk
    net = train(net,in,out);
    % Speichert das neuronale Netz für die spätere Verwendung
    save('neuronal.mat', 'net');
end
