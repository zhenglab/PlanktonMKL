Information
===========

This package contains the following two folders:

* Dataset: This folder contains three datasets (ASLO, Kaggle, and ZooScan).
* Code: This folder contains the code of our method, which classifies plankton images using multiple features combination via multiple kernel learning. 

References
==========

[1] Heidi M. Sosik and Robert J. Olson. Automated taxonomic classification of phytoplankton sampled with imaging‐in‐flow cytometry. Limnology and Oceanography: Methods, 5(2):204-216, 2007.

[2] Kaggle National Data Science Bowl: Predict ocean health, one plankton at a time. https://www.kaggle.com/c/datasciencebowl.

[3] Gaby Gorsky, Mark D Ohman, Marc Picheral, St ́ephane Gasparini, Lars Stemmann, Jean-Baptiste Romagnan, Alison Cawood, St ́ephane Pesant, Carmen Garc ́ıa-Comas, and Franck Prejger. Digital zooplankton image analysis using the ZooScan integrated system. Journal of Plankton Research, 32(3):285–303, 2010.

[4] Haibin Ling and David W Jacobs. Shape classification using the inner-distance. IEEE Transactions on Pattern Analysis and Machine Intelligence, 29(2):286–299, 2007.

[5] Corinna Cortes, Mehryar Mohri, and Afshin Rostamizadeh. Learning non-linear combinations of kernels. Advances in Neural Information Processing Systems, pages 396–404, 2009.

System Requirement
==================

* Linux or OS X
* MATLAB

Basic Usage
===========

1. The code includes five parts: 1 image preprocessing, 2 feature extraction, 3 feature selection, 4 cross validation, 5 multiple kernel learning. After downloading the code, you need to run them sequentially.

2. If there are files "*.sh" in a folder, run these files in terminal firstly please. Then, run "*.m" in MATLAB.

3. If the last element of a filename is digit, it indicates that you need to run this file according to the order of digit. Conversely, if the last element of a filename isn't digit, this file can be run in no order.

4. You need not run the files in "function" or "featuresFunction" folders by yourself, because these files are some functions or some dependent libraries.
