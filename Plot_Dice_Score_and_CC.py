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
import csv 
 
def dice(pred, true, k = 1):
    intersection = np.sum(pred[true==k]) * 2.0
    dice = intersection / (np.sum(pred) + np.sum(true))
    return dice

# dice_score = dice(y_pred, y_true, k = 255) #255 in my case, can be 1 
# print ("Dice Similarity: {}".format(dice_score))

path1 = '/content/drive/MyDrive/Code_to_GAN2/data2select_Model_pix2pix/'
save_path = '/content/drive/MyDrive/Code_to_GAN2/'
path_1 = '/content/drive/MyDrive/Code_to_GAN2/data2select_Model/'
models = os.listdir(path1)
print(path1)
numberOfModels = len(models)
print(len(models))
coff_1 = []
diceScore_1 = []
for number1 in range(69, 200):# numberOfModels 115
    path2 = path1 + 'gen_' + str(101+number1) + '.h5' + '/' #path2 = path1 + models[number1] + '/'
    sunjects = os.listdir(path2)
    print(path2)
    numberOfsunjects = len(sunjects)
    coff_2 = []
    diceScor_2 = []
    for number2 in range(0, numberOfsunjects):
        path3 = path2 + sunjects[number2] + '/'
        print(path3)
        images = os.listdir(path3)
        numberOfimages = len(images)
        for number3 in range(0, numberOfimages):
            path4 = path3 + images[number3]
            img4 = cv2.imread(path4)
            img4 = cv2.cvtColor(img4, cv2.COLOR_BGR2GRAY)
            print(path4)
            path5 = path_1 + sunjects[number2] + '/' + 'nm-03.png'
            img5 = cv2.imread(path5)
            img5 = cv2.resize(img5, (256, 256))
            img5 = cv2.cvtColor(img5, cv2.COLOR_BGR2GRAY)
            dice_score = dice(img4, img5, k = 1) #255 in my case, can be 1 
            print ("Dice Similarity: {}".format(dice_score*100))
            diceScor_2.append(dice_score*100)
            x_simple = np.array(img4)
            y_simple = np.array(img5)
            my_rho = np.corrcoef(x_simple, y_simple)
            my_rho = cv2.mean(my_rho)
            print ("Correlation Coefficient: {}".format(my_rho[0]))
            coff_2.append(my_rho[0])

            path6 = path_1 + sunjects[number2] + '/' + 'nm-04.png'
            img6 = cv2.imread(path6)
            img6 = cv2.resize(img6, (256, 256))
            img6 = cv2.cvtColor(img6, cv2.COLOR_BGR2GRAY)
            dice_score = dice(img4, img6, k = 1) #255 in my case, can be 1 
            print ("Dice Similarity: {}".format(dice_score*100))
            diceScor_2.append(dice_score*100)
            x_simple = np.array(img4)
            y_simple = np.array(img6)
            my_rho = np.corrcoef(x_simple, y_simple)
            my_rho = cv2.mean(my_rho)
            print ("Correlation Coefficient: {}".format(my_rho[0]))
            coff_2.append(my_rho[0])

            path7 = path_1 + sunjects[number2] + '/' + 'nm-05.png'
            img7 = cv2.imread(path7)
            img7 = cv2.resize(img7, (256, 256))
            img7 = cv2.cvtColor(img7, cv2.COLOR_BGR2GRAY)
            dice_score = dice(img4, img7, k = 1) #255 in my case, can be 1 
            print ("Dice Similarity: {}".format(dice_score*100))
            diceScor_2.append(dice_score*100)
            x_simple = np.array(img4)
            y_simple = np.array(img7)
            my_rho = np.corrcoef(x_simple, y_simple)
            my_rho = cv2.mean(my_rho)
            print ("Correlation Coefficient: {}".format(my_rho[0]))
            coff_2.append(my_rho[0])

            path8 = path_1 + sunjects[number2] + '/' + 'nm-06.png'
            img8 = cv2.imread(path8)
            img8 = cv2.resize(img8, (256, 256))
            img8 = cv2.cvtColor(img8, cv2.COLOR_BGR2GRAY)
            dice_score = dice(img4, img8, k = 1) #255 in my case, can be 1 
            print ("Dice Similarity: {}".format(dice_score*100))
            diceScor_2.append(dice_score*100)
            x_simple = np.array(img4)
            y_simple = np.array(img8)
            my_rho = np.corrcoef(x_simple, y_simple)
            my_rho = cv2.mean(my_rho)
            print ("Correlation Coefficient: {}".format(my_rho[0]))
            coff_2.append(my_rho[0])
    
    diceScor = cv2.mean(np.array(diceScor_2))
    print ("Average Dice Similarity: {}".format(diceScor[0]))
    diceScore_1.append(diceScor[0])
    print ("Average Dice Similarities: ", diceScore_1)
    coff = cv2.mean(np.array(coff_2))
    print ("Average Correlation Coefficient: {}".format(coff[0]))
    coff_1.append(coff[0])
    print ("Average Correlation Coefficients: ", coff_1)

    with open('/content/drive/MyDrive/Code_to_GAN3/diceScore.csv', 'w') as f:                
        writer = csv.writer(f)# create the csv writer          
        writer.writerow(diceScore_1) 

    with open('/content/drive/MyDrive/Code_to_GAN3/coff.csv', 'w') as f:                
        writer = csv.writer(f)# create the csv writer          
        writer.writerow(coff_1) 