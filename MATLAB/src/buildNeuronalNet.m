%{
    Erstellt und trainiert ein neuronales Netz zur Musterkennung, um
    Buchstaben auf Bildern zu erkennen. 

    in:  (x*y)x1 Cell-Arrays mit Eingabebildern. Schwarz = 1, Weiß = 0;
    out: 36x1 Cell-Arrays mit Zielwerten.
%}
    
function net = buildNeuronalnet(in,out)

    net = patternnet(10);

    % Netzwerk trainieren.
    net = train(net,in,out);
end
