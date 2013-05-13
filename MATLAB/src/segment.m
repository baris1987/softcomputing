% Segmentiert das �bergebene Bild und gibt die einzellnen Segmente zur�ck
function [retVal] = segment(bounded)

    % Legt die R�ckgabe Matrix auf die Gr��e auf 30x30 pro Buchstabe fest
    retVal = zeros(30, 30, 6);

    % Findet die einzellnen Buchstaben und gibt den Pixeln Nummern von 1-6
    cc = bwconncomp(bounded);
    labeled = labelmatrix(cc);
  
    charIndex = 1;
    while (charIndex <= 6)
        % Sucht die Position der einzellnen Pixel mit der gegebenen
        % Buchstabenposition
        [yPx,xPx] = find(labeled == charIndex);
        % Erstellt ein neues Bild mit der Gr��e des Eingabebildes
        singleChar = zeros(size(bounded)); 
        % F�gt die Pixel des einzelnen Buchstaben in die leere Matrix ein
        singleChar(labeled == charIndex)= bounded(labeled == charIndex); 
        % K�rzt das Bild auf die exakte Gr��e des Buchstaben
        a = imcrop(singleChar, [min(xPx),  min(yPx),  max(xPx) - min(xPx), max(yPx) -  min(yPx)]);
        [charRows, charCols] = size(a);
        % �ndert die Matrixgr��e auf 30x30 und schiebt den Buchstaben in
        % die obere linke Ecke
        a = padarray(a, [(30 - charRows) (30 - charCols)], 'post');
        % Speichert das Bild in den Returnwert
        retVal(:,:,charIndex) = a;
        charIndex = charIndex + 1;
    end
end