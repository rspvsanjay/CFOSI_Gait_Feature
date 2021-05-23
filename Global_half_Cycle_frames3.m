path1='H:\Gait_IIT_BHU_Analysis\Silhouette_frames_Selected_big_blob_Extracted_Centered_Alinged_Directed_splitted_Alinged_Directed_Half_Cycle\';
save_path='H:\Gait_IIT_BHU_Analysis\Refernced_Half_Gait_Cycle\Refernced_Half_Gait_Cycle_19\';
%save_path1='H:\Neurocomputing_COFEI\Treadmill_dataset\Pose_Directory_for_CNN3\';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
path1
save_path
pose_frame = cell(0,0);
length_of_HC = 19;
for num = 1:length_of_HC
    pose_frame{num} = double(zeros(256,256));
end
count1 = 0;
mkdir(save_path);
for f_no=3:y1
    path2 = char(strcat(path1,fName1(f_no),'\'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2] = size(fName2);
    fName1(f_no)
    for ff_no=3:y2
        path3 = char(strcat(path1,fName1(f_no),'\',fName2(ff_no),'\'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3]=size(fName3);
        count = 0;
        if y3-2==length_of_HC
            count1 = count1 + 1;
            for fff_no = 3:y3
                image2 = double(imread(char(strcat(path3,fName3(fff_no)))));
                count = count+1;
                image2 = image2/255;
                pose_frame{count} = pose_frame{count} + image2;
%                 if (fff_no-2)<10
%                     if ~exist(char(strcat(save_path1,'pose0',int2str(fff_no-2),'\')),'dir')
%                         mkdir(char(strcat(save_path1,'pose0',int2str(fff_no-2),'\')));
%                     end
%                     imwrite(image2,char(strcat(save_path1,'pose0',int2str(fff_no-2),'\',int2str(count),fName3(fff_no))));
%                 else
%                     if ~exist(char(strcat(save_path1,'pose',int2str(fff_no-2),'\')),'dir')
%                         mkdir(char(strcat(save_path1,'pose',int2str(fff_no-2),'\')));
%                     end
%                     imwrite(image2,char(strcat(save_path1,'pose',int2str(fff_no-2),'\',int2str(count),fName3(fff_no))));
%                 end
                
            end
        end
    end
end

for num = 1:length_of_HC
    max1 = max(pose_frame{num}(:));
    pose_frame{num} = pose_frame{num}/max1;
    %     figure,imshow(pose_frame{num});
    if num<10
        imwrite(pose_frame{num},char(strcat(save_path,'pose0',int2str(num),'.png')));
    else
        imwrite(pose_frame{num},char(strcat(save_path,'pose',int2str(num),'.png')));
    end
end
count1
