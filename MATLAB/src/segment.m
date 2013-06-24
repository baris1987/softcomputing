% Segmentiert das übergebene Bild und gibt die einzelnen Segmente zurück
function [retVal] = segment(bounded)

    retVal = zeros(30, 30, 6);

    cc = bwconncomp(bounded);
    labeled = labelmatrix(cc);
  
    charIndex = 1;
    while (charIndex <= 6)

        % Sucht die Position der einzelnen Pixel mit der gegebenen Buchstabenposition
        [yPx,xPx] = find(labeled == charIndex);
        singleChar = zeros(size(bounded)); 

        % Fuegt die Pixel des einzelnen Buchstaben in die leere Matrix ein
        singleChar(labeled == charIndex)= bounded(labeled == charIndex); 

        % Schneidet das einzelne Zeichen aus dem Gesamtbild heraus
        a = imcrop(singleChar, [min(xPx),  min(yPx),  max(xPx) - min(xPx), max(yPx) -  min(yPx)]);
        [charRows, charCols] = size(a);

        % Aendert die Matrixgroesse auf 30x30
        a = padarray(a, [(30 - charRows) (30 - charCols)], 'post');
        
        % Speichert das Bild in den Returnwert
        retVal(:,:,charIndex) = a;
        charIndex = charIndex + 1;
    end
end