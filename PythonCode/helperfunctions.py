import csv
import numpy as np
from matplotlib import pyplot
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM
from keras.layers import Flatten
from keras.layers import Dropout

DELIMITER = ','


def read_file_names(filename, path):
    """ read_FileNames(filename,path) returns the List of names of time series files based on the given path and name
    of the file where the names are stored. """
    namesList = []
    with open(path+filename, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            namesList.append(row)
    return namesList


def read_labels(filename, path):
    """ read_Labels(filename,path) returns the List of Labels of time series files based on the given path and name
        of the file where the labels are stored. """
    labelList = []
    with open(path+filename, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            labelList.append(row)
    return labelList


def read_one_time_series(filename, path):
    """ read_one_TimeSeries(filename,path) returns the matrix of the time series data, specified by filename and path.
    The file is specified as """
    data = np.loadtxt(path+filename, delimiter=DELIMITER)
    return data


def shape_data_all(name_list, path): # for all datasets at once
    """ [samples,timesteps,features]"""
    array3d = []
    array2d = []
    for i in range(len(name_list)):
        array2d = np.array(read_one_time_series(name_list[i][0], path))
        array3d.append(array2d)
    array3d = np.array(array3d)
    array3d.reshape(len(name_list), array2d.shape[0], array2d.shape[1])
    return array3d


def shape_data_one(name, path):  # if only one dataset shall be used e.g. for loop training --> output 2 dimensional
    """ [samples,timesteps,features]"""
    array2d = np.array(read_one_time_series(name, path))
    np.reshape(array2d, array2d.shape + (1,))
    return array2d


def define_model(training_data):
    m = Sequential()
    lstm_size_l1 = 13                 # size of the hidden layer 1
    m.add(LSTM(lstm_size_l1, input_shape=(training_data.shape[1], training_data.shape[2]), return_sequences=True,
               recurrent_dropout=0.2))
    m.add(Dropout(0.2))
    # input shape: numTimeSteps, numFeatures per TimeStep
    m.add(LSTM(2*lstm_size_l1,return_sequences=True, recurrent_dropout=0.2))
    m.add(Dropout(0.2))
    m.add(LSTM(lstm_size_l1,return_sequences=True, recurrent_dropout=0.2))
    m.add(Dropout(0.2))
    m.add(Flatten())
    # output layer for classification
    m.add(Dense(1, activation='sigmoid'))
    m.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])  # for classification problems
    plot(m, to_file='model.png', show_shapes=True, show_layer_names=True)
    return m


if __name__ == '__main___':
    path = 'TestRun1/'
    fileNameNames = 'NamesTraining.csv'
    fileNameLabels = 'LabelsTraining.csv'

    c = read_file_names(fileNameNames, path)
    x = shape_data_all(c, path)
    y = np.array(read_labels(fileNameLabels, path))
    model = define_model(x)
    model.fit(x, y, epochs=1, batch_size=1)

    fileNameNames = 'NamesTest.csv'
    fileNameLabels = 'LabelsTest.csv'
    c = read_file_names(fileNameNames, path)
    x = shape_data_all(c, path)
    y = np.array(read_labels(fileNameLabels, path))
    score = model.evaluate(x, y, batch_size=1)
    print(score)
    print('Hallo')
