import pickle
import keras

import matplotlib as mpl
mpl.use("pgf")



import matplotlib.pyplot as plt
import numpy

history = pickle.load( open( "history", "rb" ) )

# summarize history for loss
plt.plot(history['loss'])
plt.plot(history['val_loss'])
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'valid'], loc='upper left')
plt.show()

