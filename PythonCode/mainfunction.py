import helperfunctions as hf
import numpy as np
import h5py
import pickle
import math

PATH = 'TestRun1/'
#PATH = 'TestRun_minimal/'

trainingNames = hf.read_file_names('NamesTraining.csv', PATH)
trainingLabels = hf.read_labels('LabelsTraining.csv', PATH)

# network definition based on one training set


model = hf.define_model(hf.shape_data_all(trainingNames[0:2], PATH))  # only two TS needed for creation of model


y = np.array(trainingLabels)
#model.fit(x, y, epochs=1, batch_size=20, validation_split=0.33)
validationNames = hf.read_file_names('NamesValidation.csv', PATH)
validationLabels = np.array(hf.read_labels('LabelsValidation', PATH))

steps_epoch = len(trainingNames)
size = 1
history = model.fit_generator(hf.data_generator(trainingNames, y, PATH),
                    validation_data=hf.data_generator(validationNames, validationLabels, PATH),
                    validation_steps=len(validationNames), steps_per_epoch=len(trainingNames), epochs=10,
                    use_multiprocessing=True)

# x = hf.shape_data_all(trainingNames, PATH)


testNames = hf.read_file_names('NamesTest.csv', PATH)
x = hf.shape_data_all(testNames, PATH)
y = np.array(hf.read_labels('LabelsTest.csv', PATH))

filename = 'activationMatrix_L1'
outfile = open(filename, 'wb')
pickle.dump(hf.get_layer_output(model, 1, x), outfile)
outfile.close()
filename = 'activationMatrix_L2'
outfile = open(filename, 'wb')
pickle.dump(hf.get_layer_output(model, 3, x), outfile)
outfile.close()
filename = 'activationMatrix_L3'
outfile = open(filename, 'wb')
pickle.dump(hf.get_layer_output(model, 5, x), outfile)
outfile.close()

filename = 'History'
outfile = open(filename,'wb')
pickle.dump(history, outfile)
outfile.close()

score = model.evaluate(x, y, batch_size=5)
print("\n%s: %.2f%%" %(model.metrics_names[1], score[1]*100))

model.save(PATH+'Model.h5')

