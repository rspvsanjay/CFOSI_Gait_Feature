import scipy.misc
from glob import glob
import numpy as np
import matplotlib.pyplot as plt
import os
import cv2
class DataLoader():

    def __init__(self, dataset_name, img_res=(128, 128)):

        self.dataset_name = dataset_name


        self.img_res = img_res

    def load_data(self, batch_size=1, is_testing=False):

        data_type = "GEI_data_to_train_GAN2"
        path = glob('/content/drive/MyDrive/Reconstruct_GEI_Gait_IIT_BHU/%s/%s/*.png' % (self.dataset_name,data_type))
        #print("hello")
        #print(path)
        batch_images = np.random.choice(path, size=batch_size)
        print(batch_images)

        imgs_A = []
        imgs_B = []
        for img_path in batch_images:
            #img = self.imread(img_path)
            img = cv2.imread(img_path)
            #print(img)
            h, w, _ = img.shape
            _w = int(w/2)
            img_A, img_B = img[:, :_w, :], img[:, _w:, :]

            #img_A = scipy.misc.imresize(img_A, self.img_res)
            #img_B = scipy.misc.imresize(img_B, self.img_res)
            img_A = cv2.resize(img_A, self.img_res)
            img_B = cv2.resize(img_B, self.img_res)

            # If training => do random flip
            if not is_testing and np.random.random() < 0.5:
                img_A = np.fliplr(img_A)
                img_B = np.fliplr(img_B)

            imgs_A.append(img_A)
            imgs_B.append(img_B)

        imgs_A = np.array(imgs_A)/255.0
        imgs_B = np.array(imgs_B)/255.0

        return imgs_A, imgs_B

    def load_batch(self, batch_size=1, is_testing=False):

        data_type = "GEI_data_to_train_GAN2" if not is_testing else "val"
        path = glob('/content/drive/MyDrive/Reconstruct_GEI_Gait_IIT_BHU/%s/%s/*.png' % (self.dataset_name,data_type))
        self.n_batches = int(len(path) / batch_size)

        for i in range(self.n_batches-1):
            batch = path[i*batch_size:(i+1)*batch_size]
            imgs_A, imgs_B = [], []
            for img in batch:
                #print(img)
                img = cv2.imread(img)
                #img = self.imread(img)
                h, w, _ = img.shape
                half_w = int(w/2)
                img_A = img[:, :half_w, :]
                img_B = img[:, half_w:, :]
                #print(self.img_res)
                #img_A = scipy.misc.imresize(img_A, self.img_res)
                #img_B = scipy.misc.imresize(img_B, self.img_res)
                img_A = cv2.resize(img_A, self.img_res)
                img_B = cv2.resize(img_B, self.img_res)

                if not is_testing and np.random.random() > 0.5:
                        img_A = np.fliplr(img_A)
                        img_B = np.fliplr(img_B)

                imgs_A.append(img_A)
                imgs_B.append(img_B)

            imgs_A = np.array(imgs_A)/255.0
            imgs_B = np.array(imgs_B)/255.0

            yield imgs_A, imgs_B



    def imread(self, path):
        #return scipy.misc.imread(path, mode='RGB').astype(np.float)
        return cv2.imread(path, 1).astype(np.float)