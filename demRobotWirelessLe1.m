% DEMROBOTWIRELESSLE1 Model the stick man with LE using 7 neighbors.

% MEU

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'robotWireless';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
latentDim = 2;
options = leOptions(7);

d = size(Y, 2);
model = leCreate(latentDim, d, Y, options);

% Optimise the model.
iters = 1000;
display = 3;

model = leOptimise(model, display, iters);


if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
else
  clf;
  lvmScatterPlot(model, lbls);
end
fprintf('Scoring model.\n');
model.score = lvmScoreModel(model);
fprintf('Model score %2.4f/n', model.score);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

