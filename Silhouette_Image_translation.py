import tensorflow as tf
import keras
import cv2
import numpy as np
from keras.models import load_model
import matplotlib
import os
import matplotlib.image
from PIL import Image
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import statistics
path_11 = r'/DATA/Sanjay/Code_For_GAN33/model_gen2/'
count=1;
files = os.listdir(path_11)

for names in files:    
    generator = load_model(path_11+names)
    arr1 = names.split('.')
    path1 = '/run/media/Sanjay/SANJAY_HD/PLVEI_TUMGAID_data/AEI_PEI/' 
    path_2 = '/DATA/Sanjay/Code_For_GAN33/PLVEI_TUMGAID_GAN/AEI_PEI_TUMGAID/'
    print(names)
   
    try:
        os.makedirs(path_2)
    except OSError:
        print ("")
    else:
        print (" ")
    subjects = os.listdir(path1)
    #print(path1)
    numberOfSubject = len(subjects)
    for number1 in range(0 , numberOfSubject):  
        path2 = (path1 + subjects[number1] + '/')    
        sequences = os.listdir(path2)
        #print(path2)
        numberOfsequences = len(sequences)
        
        for number2 in range(0, numberOfsequences):  
            path3 = (path2 + sequences[number2]+'/') 
            #print(path3)
            sequences1 = os.listdir(path3)
            numberOfsequences1 = len(sequences1)
            for number3 in range(0, numberOfsequences1): 
                path4 = (path3 + sequences1[number3]) 
                #print(path4) 
                img=cv2.imread(path4)            
                img = cv2.resize(img,(256,256))            
                img = np.array(img)/255.0
                img=np.expand_dims(img,axis=0)                
	
                arr1 = path4.split('.')
                arr2 = arr1[0].split('/')
                path = path_2 + arr2[len(arr2)-3] + '/'+arr2[len(arr2)-2] + '/'
                print(path)
    
                try:
                    os.makedirs(path)
                except OSError:
                    print ("")
                else:
                    print (" ")
                path = path_2 + arr2[len(arr2)-3] + '/'+arr2[len(arr2)-2] + '/'+arr2[len(arr2)-1]
                for num in range(0, 1):
                    img1 = generator.predict(img)
                    img_1 = np.reshape(img1, (256, 256, 3))
                    #print(img1.shape)
                    img_1[img_1<0] = 0 
                    #print(img_1.max()) 
                    img = (img_1/(img_1.max()))
                    #img = (1/(2*2.25)) * img_1
                    matplotlib.image.imsave(path+'.png', img)
                    count = count + 1
                    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
                    gray[gray<np.mean(gray)] = 0.
                    gray[gray>=np.mean(gray)] = 255.
                    #print(gray.shape)
                    img = np.stack((gray,)*3, axis=-1)
                    #print(img.shape)
                    img = np.array(img) / 255.0
                    img = np.expand_dims(img, axis=0)
                    #print(img.shape)


    #pre-constructed pose sets (PCPS)
    




