import helperfunctions as hf
import numpy as np

PATH = 'TestRun1/'

trainingNames = hf.read_file_names('NamesTraining.csv', PATH)
trainingLabels = hf.read_labels('LabelsTraining.csv', PATH)

# network definition based on one training set
model = hf.define_model(hf.shape_data_all(trainingNames, PATH))

x = hf.shape_data_all(trainingNames, PATH)
y = np.array(trainingLabels)
model.fit(x, y, epochs=1, batch_size=20, validation_split=0.33)

a = hf.get_layer_output(model,1,x)


testNames = hf.read_file_names('NamesTest.csv', PATH)
x = hf.shape_data_all(testNames, PATH)
y = np.array(hf.read_labels('LabelsTest.csv', PATH))
score = model.evaluate(x, y, batch_size=5)
print(score)

