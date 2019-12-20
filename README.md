Img2txt
=======

Img2txt will extract text and numbers from images.
It has Qt QML GUI with C++ backend and uses OpenCV library.
CMake is used as a build system.


ToDo
----

1. Detect text presence and position in images (segmentation).
Options:
- use sliding (and rotating?) window technique and detect highly connected objects
- or train a neural network to detect letters and digits presence and positions:
  - create data set of augmented letters and digits with different font and on different backgrounds
  - create "negative" data set without letters?
  - use YOLO as a library to get letters and digits bounding boxes
  - or implement a Convolutional Neural Network in Python (Tensorflow)
  - load the trained NN model with the OpenCV C++ API
- or detect other text features?

2. Text segment pre-processing.
- image enhancement
- shadow removal?
- proper rotation?

3. Letter and digit recognition (classification).
Options:
- use Tessaract library
- or take the class directly from YOLO or the CNN

4. Display the results in the GUI.
Options:
- cluster letters and digits in words and numbers based on bounding box centers (detect lines of centers)
- or expand individual letter boxes and unite them when they overlap
