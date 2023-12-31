function model = trainSillyWalkClassifier(XTrain, YTrain)
    % Define the network architecture
    inputDimension = 3;
    hiddenUnits = 40;
    numClasses = 2;

    layers = [
        sequenceInputLayer(inputDimension)
        lstmLayer(hiddenUnits,'OutputMode','last')
        dropoutLayer
        reluLayer
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];

    % Set training options
    maxEpochs = 20;
    miniBatchSize = 32;
    options = trainingOptions('adam', ...
        'ExecutionEnvironment','cpu', ...
        'GradientThreshold',Inf, ...
        'MaxEpochs',maxEpochs, ...
        'MiniBatchSize',miniBatchSize, ...
        'SequenceLength','longest', ...
        'Shuffle','once', ...
        'Verbose',0, ...
        'Plots','training-progress');

    % Train the network
    model = trainNetwork(XTrain, YTrain, layers, options);

    % Save the trained model
    save(fullfile(fileparts(mfilename('fullpath')), 'Model.mat'), 'model'); % do not change this line