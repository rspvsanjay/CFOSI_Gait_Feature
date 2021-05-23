path = 'H:\CFOSI\TUM_GAID\Refernced_Half_Gait_Cycle_27\';
keys = 27;
list = dir(path);
fName = {list.name};
[~,y]=size(fName);
poses = cell(0,0);
for pose_no=3:y
    poses{pose_no-2}=double(imread(char(strcat(path,fName(pose_no)))));
end
path1 = 'H:\CFOSI\TUM_GAID\Depth_Cropped_Fliped_Renamed_BinaryImageShifted_Fliped_one_cycle\';
save_path='H:\CFOSI\TUM_GAID\Depth_Cropped_Fliped_Renamed_BinaryImageShifted_Fliped_one_cycle_27_Renamed\';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
save_path
for f_no=3:103%y1
    path2=char(strcat(path1,fName1(f_no),'\'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2]=size(fName2);
    fName1(f_no)
    for ff_no=3:y2
        path3= char(strcat(path2,fName2(ff_no),'\'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3]=size(fName3);
        if y3==(keys+2)
            v = cell(y-2,y3-2);
            for pose_num=1:y-2
                for fff_no=3:y3
                    image=double(imread(char(strcat(path3,fName3(fff_no)))));
                    r=corr2(poses{pose_num},image);
                    v{pose_num}=[v{pose_num},r];
                end
            end
            mat1 = double([]);
            for pose_num=1:y-2
                mat1 = [mat1,v{pose_num}];
            end
            mat2 = (1-mat1);
            fourthofNodes = length(mat2)/(y-2);
            s=[];
            t=[1];
            for num=1:(y-2)
                s=[s,length(mat2)+2];%s is vector of elements, connectivity start from
            end
            for num=1:(y-3)
                t=[t,fourthofNodes*num+1]; % t target vector respect to vector s correspondings
            end
            for num=1:length(mat2)
                if mod(num,fourthofNodes)~=0
                    s=[s,num,num];
                    if num<=fourthofNodes*(y-3)
                        t=[t,num+1,num+fourthofNodes+1];
                    else
                        t=[t,num+1,mod(num+fourthofNodes,length(mat2))+1];
                    end
                end
            end
            %         [a,b]=size(mat2);
            weights = [];
            for num=1:length(t)
                weights = [weights,mat2(t(num))];
            end
            for num=1:(y-2)
                s=[s,fourthofNodes*num];%s is vector of elements, connectivity start from
            end
            for num=1:(y-2)
                t=[t,length(mat2)+1]; % t target vector respect to vector s correspondings
                weights = [weights,0.99];
            end
            weights(isnan(weights))=0;
            G = digraph(s,t,weights);
            
            %             figure,plot(G,'EdgeLabel',G.Edges.Weight);
            [p,d] = shortestpath(G,length(mat2)+2,length(mat2)+1);
            
            poseNumber=[];
            frameNumber=[];
            for num=1:fourthofNodes
                frameNumber = [frameNumber,num];
            end
            for num=2:length(p)-1
                if int16(p(num)/fourthofNodes)<(p(num)/fourthofNodes)
                    poseNumber = [poseNumber,int16(p(num)/fourthofNodes)+1];
                    %                 frameNumber = [frameNumber,((p(num)/fourthofNodes)-double(int16(p(num)/fourthofNodes)))*fourthofNodes];
                end
                if int16(p(num)/fourthofNodes)>(p(num)/fourthofNodes)
                    poseNumber = [poseNumber,int16(p(num)/fourthofNodes)];
                    %                 frameNumber = [frameNumber,double(int16(p(num)/fourthofNodes)-(p(num)/fourthofNodes))*fourthofNodes];
                end
                if int16(p(num)/fourthofNodes)==(p(num)/fourthofNodes)
                    poseNumber = [poseNumber,int16(p(num)/fourthofNodes)];
                    %                 frameNumber = [frameNumber,int16(p(num)/fourthofNodes)*fourthofNodes];
                end
            end
            
            if ~exist(char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\')),'dir')
                mkdir(char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\')));
            end
            
            for pose_num=1:y-2
                for num=1:length(frameNumber)
                    if poseNumber(num)==pose_num
                        image = double(imread(char(strcat(path3,fName3(frameNumber(num)+2)))));
                        max1=max(image(:));
                        image = image/max1;
                        %                     pei{pose_num} = pei{pose_num}+image;
                        if num<10
                            if pose_num<10
                                imwrite(image,char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\0',int2str(num),'pose0',int2str(pose_num),'.png')));
                            else
                                imwrite(image,char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\0',int2str(num),'pose',int2str(pose_num),'.png')));
                            end
                        else
                            if pose_num<10
                                imwrite(image,char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\',int2str(num),'pose0',int2str(pose_num),'.png')));
                            else
                                imwrite(image,char(strcat(save_path,fName1(f_no),'\',fName2(ff_no),'\',int2str(num),'pose',int2str(pose_num),'.png')));
                            end
                        end
                    end
                end
            end
        end
    end
end