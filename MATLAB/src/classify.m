% Berechnet den Input f�rs Neuronale Netz und stellt die Anfrage ans
% Neuronale Netz
function decoded = classify(chars)
    % L�dt das Neuronale Netz
    load neuronal;
    % Erstellt die R�ckgabevariable der Anzahl von 6 Buchstaben
    decoded = char(zeros(1,6));
    
    for i=1:6

        % Summiert die Vertikalen und Horizontalen Pixel auf und �bergibt
        % diese dem Neuronalen Netz
        inVP = sum(chars(:,:,i),2);
        inHP = sum(chars(:,:,i)',2);
        res = net([inVP;inHP]);
   
        % Sucht den R�ckgabewert mit der besten Korrelation
        index = find(res == max(res), 1);
        
        % Konvertiert das R�ckgabeergebniss zur�ck zu einem ASCII
        % Buchstaben
        % Nummer 1 - 10, Buchstabe 11 - 36
        if (index <= 10)
            index = index + 47;
        elseif (index >= 11 && index <= 36)
            index = index + 54;
        end
        % Speichert den gefundenen Buchstaben in der R�ckgabevariable
        decoded(i) = char(index);
    end
end