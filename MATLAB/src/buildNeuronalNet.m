%{
    Erstellt und trainiert ein neuronales Netz zur Musterkennung, um
    Buchstaben auf Bildern zu erkennen. 

    x: Anzahl der Pixel in x-Richtung
    y: Anzahl der Pixel in y-Richtung
    in:  (x*y)x1 Cell-Arrays mit Eingabebildern. Schwarz = 1, Weiß = 0;
    out: 36x1 Cell-Arrays mit Zielwerten.
%}
    
function net = buildNeuronalnet(x,y,in,out)

    net = patternnet(10);

    % Jedes Pixel ist ein Eingabewert ins neuronale Netz.
    net.inputNum = x*y;
    
    % 10 Zahlen und 26 Buchstaben
    net.outputNum = 36;
    
    % Netzwerk trainieren.
    train(net,in,out);
end