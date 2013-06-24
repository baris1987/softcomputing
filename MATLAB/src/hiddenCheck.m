hidden = 51;
while (hidden <= 100)
    trainPerf = 1;
    trainCount = 0;
    while(trainCount < 5)
        [net, training] = buildNetwork(hidden);
        if(trainPerf > training.best_perf)
            trainPerf = training.best_perf;
            save('neuronal.mat', 'net');
        end
        trainCount = trainCount + 1;
    end
    [char, cap] = runTest();
    fprintf('%d: Buchstaben Erkennungsrate: %f\t Captcha Erkennungsrate: %f\n',hidden, char, cap);
    hidden = hidden + 1;
end
