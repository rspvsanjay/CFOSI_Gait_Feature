# CFOSI_Gait_Feature

The code is implimented using MATLAB and python scripts. That is made for a research work of "Reduction of Covariate Factors from Silhouette Image for Robust Gait Recognition".
DOI: https://doi.org/10.1007/s11042-021-10941-w 

The conditional GAN has been used for the generation of CFOSI feature. The pix2pix conditional GAN description be found by: 
https://ieeexplore.ieee.org/document/8100115

The Sample data is related to research work of "On using gait in forensic biometrics".
https://pubmed.ncbi.nlm.nih.gov/21554307/

To get the feature follow the sequence to run the files:

If you have normalized silhouette frames then first run (1) Select_doubble_support_frames.m file that will provide you a globel frame with double support.
(2) Half_cycle_selection_03.m this will provide the half gait cycles from each sequence of subjects.
(3) CountCycleLength2.m this will provide you number of sequences with respect to a length of sequence.
(4) Global_frame_Sequence.m this will provide you globel half cycle with a constant number of poses.
(5) Label_key_frames_through_PEI.m this will lable frames with a pose number.
(6) Code_to_make_pairs_of_Silhouette_to_train_GAN.m after labeling you can get the frame pairs to train the conditional GAN model.
(7) data_loader.py pix2pix.py run the pix2pix.py file that will involve the data_loader.py code to train GAN model.
(8) Silhouette_Image_translation.py transalate the silhouette images from some subjects with respect to saved models.
(9) Plot_Dice_Score_and_CC.py modify this code and get the correlation and dice score to select the relevent model to get silhouette feature
(10) Finaly, you can use the modified version of Silhouette_Image_translation.py to get the final feature for the published paper.

thank you

