hidden = 1;
while (hidden <= 100)
    i = 1;
    charComplete = 0;
    capComplete = 0;
    fprintf('Start check for hidden = %d\n', hidden);
   
    while(i <= 10)
       buildNetwork(hidden);
       [char, cap] = recognizeAll();
       charComplete = charComplete + char;
       capComplete = capComplete + cap;
       fprintf('%d: Character Accuracy: %f\t Captcha Accuracy: %f\n',i, char, cap);
       i = i+1;
    end
    hidden = hidden + 1;
    fprintf('Complete: Character Accuracy: %f\t Captcha Accuracy: %f\n', charComplete / 10, capComplete / 10);
end
