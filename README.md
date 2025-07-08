Img2txt
=======

Img2txt will extract text and numbers from images.
It has Qt QML GUI with C++ backend and uses OpenCV library.
CMake is used as a build system.


ToDo
----

1. Detect text presence and position in images (localization).
Options:
    - use sliding (and rotating?) window technique and detect highly connected objects
    - train a neural network to detect letters and digits presence and positions:
        - create data set of augmented letters and digits with different font and on different backgrounds
        - create "negative" data set without letters?
        - train a YOLO-like network to get letters and digits bounding boxes
        - load the trained NN model with OpenCV C++ API or ggml
    - use Tesseract library

2. Text segmentation and pre-processing.
    - image enhancement (convert to grayscale, filter noise, shadow removal, binarize, erode/dilate, crop, scale)
    - proper rotation

3. Letter and digit recognition (classification).
Options:
    - implement and train a CNN or vision transformer model in Python and load it from C++ for inference
    - take the class directly from YOLO
    - train a SVM from OpenCV

4. Display the results in the GUI.
Options:
    - cluster letters and digits in words and numbers based on bounding box centers (detect lines of centers)
    - or expand individual letter boxes and unite them when they overlap
    - get the words from Tesseract
