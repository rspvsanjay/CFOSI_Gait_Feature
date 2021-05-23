path1 = 'H:\CFOSI\TUM_GAID\Depth_Cropped_Fliped_Renamed_BinaryImageShifted_Fliped_one_cycle_23_Renamed\';
save_path= 'H:\CFOSI\TUM_GAID\data_pairs_of_silhouette_frames\';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
mkdir(char(save_path));
count1 = 0;
poses_num = 23;
for num=9:12
    for f_no=3:y1
        path2=char(strcat(path1,fName1(f_no),'\'));
        list2 = dir(path2);
        fName2 = {list2.name};
        [~,y2]=size(fName2);
        fName1(f_no)
        for ff_no=3:8
            path3= char(strcat(path2,fName2(ff_no),'\'));
            list3 = dir(path3);
            fName3 = {list3.name};
            [~,y3]=size(fName3);
            
            path_3 = char(strcat(path2,fName2(num),'\'));
            list_3 = dir(path_3);
            fName_3 = {list_3.name};
            [~,y_3]=size(fName_3);
            
            for pose_num=1:poses_num
                cg1 = cell(0,0);
                nm1 = cell(0,0);
                count = 1;
                for fff_no=3:y3
                    newStr = split(fName3(fff_no),'.');
                    newStr = split(newStr(1),'pose');
                    X = str2num(char(newStr(2)));
                    if (X) == pose_num
                        image = double(imread(char(strcat(path3,fName3(fff_no)))));
                        cg1{count} = image;
                        count = count + 1;
                    end
                end
                
                count = 1;
                for fff_no=3:y_3
                    newStr = split(fName_3(fff_no),'.');
                    newStr = split(newStr(1),'pose');
                    X = str2num(char(newStr(2)));
                    if (X) == pose_num
                        image = double(imread(char(strcat(path_3,fName_3(fff_no)))));
                        nm1{count} = image;
                        count = count + 1;
                    end
                end
                
                [~,a] = size(nm1);
                [~,b] = size(cg1);
                if a~=b
                    if a<b
                        a=a;
                    elseif a>b
                        a=b;
                    end
                end                
                for number = 1:a
                    image = [nm1{number},cg1{number}];
                    img = imresize(image,[256 512]);
                    imwrite(img,char(strcat(save_path,int2str(count1),'.png')));
                    count1 = count1+1;
                end
            end
        end
    end
end