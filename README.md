Img2txt
=======

Img2txt will extract text and numbers from images.
It has Qt QML GUI with C++ backend and uses OpenCV library.
CMake is used as a build system.


ToDo
----

1. Detect text presence and position in images (segmentation).
Options:
- use sliding window technique and detect highly connected objects
- train a neural network with augmented letters and digits with different font and on different backgrounds
  - use YOLO as a library to get letters and digits bounding boxes
  - or implement a Convolutional Neural Network in Python (Tensorflow)
  - load the trained NN model with the OpenCV C++ API
- detect other text features?

2. Text segment pre-processing.
- image enhancement
- shadow removal?
- proper rotation

3. Letter and digit recognition (classification).
Options:
- use Tessaract library
- take the class directly from YOLO or the CNN

4. Display the results in the GUI.
- cluster letters and digits in words and numbers based on bounding box centers
