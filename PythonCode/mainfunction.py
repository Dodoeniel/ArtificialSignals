import helperfunctions as hf

PATH = 'TestRun1/'

trainingNames = hf.read_file_names('NamesTraining', PATH)
trainingLabels = hf.read_labels('LabelsTraining',PATH)

# network definition based on one training set
model = hf.define_model(hf.shape_data(trainingNames[0], PATH))

# train network in loop over all training sets
for i in range(len(trainingNames)):
    x = hf.shape_data(trainingNames[i], PATH)
    y = trainingLabels[i]
    model.fit(x, y, epochs=10, batch_size=10)


fileNameNames = 'NamesTest.csv'
fileNameLabels = 'LabelsTest.csv'
c = hf.read_file_names(fileNameNames, PATH)
x = hf.shape_data(c, PATH)
y = np.array(hf.read_labels(fileNameLabels, PATH))
score = model.evaluate(x, y, batch_size=1)
print(score)

