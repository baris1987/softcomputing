% Berechnet den Input fürs Neuronale Netz und stellt die Anfrage ans
% Neuronale Netz
function decoded = classify(chars)
    load neuronal;
    decoded = char(zeros(1,6));
    
    for i=1:6
        inVP = sum(chars(:,:,i),2);
        inHP = sum(chars(:,:,i)',2);
        res = net([inVP;inHP]);
   
        % Sucht den Rueckgabewert mit der besten Korrelation
        index = find(res == max(res), 1);
        
        % Konvertiert das Rueckgabe-Ergebnis zurueck zu einem ASCII Zeichen
        if (index <= 10)
            index = index + 47;
        elseif (index >= 11 && index <= 36)
            index = index + 54;
        end

        decoded(i) = char(index);
    end
end