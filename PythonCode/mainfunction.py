import helperfunctions as hf
import numpy as np
import math

PATH = 'TestRun1/'
#PATH = 'TestRun_minimal/'

trainingNames = hf.read_file_names('NamesTraining.csv', PATH)
trainingLabels = hf.read_labels('LabelsTraining.csv', PATH)

# network definition based on one training set


model = hf.define_model(hf.shape_data_all(trainingNames[0:2], PATH))  # only two TS needed for creation of model


y = np.array(trainingLabels)
#model.fit(x, y, epochs=1, batch_size=20, validation_split=0.33)

steps_epoch = len(trainingNames)
size = 1
model.fit_generator(hf.data_generator2(trainingNames, y, PATH), steps_per_epoch=600, epochs=1)



# batch_size = 50
# count1 = math.floor(len(trainingNames)/batch_size)
# remainder_size = len(trainingNames) - count1*batch_size
# epochs = 10

# for l in range(epochs):
#     for i in range(count1):
#         batch = hf.create_batch(batch_size, i, trainingNames, y, PATH)
#         model.train_on_batch(batch[0], batch[1])
#         print('Training Batch ' + str(i))
#     if remainder_size != 0:
#         batch = hf.create_batch(remainder_size, count1, trainingNames, y, PATH)
#         model.train_on_batch(batch[0], batch[1])
#         print('Training Remainder')



x = hf.shape_data_all(trainingNames, PATH)
a = hf.get_layer_output(model, 1, x)



testNames = hf.read_file_names('NamesTest.csv', PATH)
x = hf.shape_data_all(testNames, PATH)
y = np.array(hf.read_labels('LabelsTest.csv', PATH))
score = model.evaluate(x, y, batch_size=5)
print("\n%s: %.2f%%" %(model.metrics_names[1], score[1]*100))

