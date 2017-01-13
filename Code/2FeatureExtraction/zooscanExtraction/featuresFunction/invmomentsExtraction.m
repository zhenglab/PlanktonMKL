function features=invmomentsExtraction(img, features)

invFeatures = invmoments(img);

features.invmoments1 = invFeatures(1,1);
features.invmoments2 = invFeatures(1,2);
features.invmoments3 = invFeatures(1,3);
features.invmoments4 = invFeatures(1,4);
features.invmoments5 = invFeatures(1,5);
features.invmoments6 = invFeatures(1,6);
features.invmoments7 = invFeatures(1,7);