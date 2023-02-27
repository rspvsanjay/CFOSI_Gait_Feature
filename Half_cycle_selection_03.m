path1 = '/DATA/sanjay/VT-GAN-master/CASIA_B/CASIA_B090degree_Centered_Alinged/';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
save_path = '/DATA/sanjay/PDEI/CASIA_B090degree_Centered_Alinged_half_Cycle/';
doubleSupport = '/DATA/sanjay/PDEI/double_support.png';
doubleSupportImage = double((imread(doubleSupport)));
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
mid=double(0);
k=0;
path1
save_path
for f_no=3:y1
    path2=char(strcat(path1,fName1(f_no),'/'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2]=size(fName2);
    fName1(f_no)
    for ff_no=7:y2
        path3= char(strcat(path1,fName1(f_no),'/',fName2(ff_no),'/'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3]=size(fName3);
        v=double([]);
        t=[];
        for fff_no = 3:y3
            image2=double(imread(char(strcat(path3,fName3(fff_no)))));
            r=corr2(doubleSupportImage,image2);
            v=[v,r];
            t=[t,fff_no-2];
        end
        [~,peakIndex1] = findpeaks(v);
        v1 = smooth(v);
        [val1,peakIndex2] = findpeaks(v1);
        vecx = [];
        for number=1:length(peakIndex2)-1
            start1 = peakIndex2(number);
            end1 = peakIndex2(number+1);
            vecx = [vecx,end1-start1];
        end
        [val,index] = max(vecx);
%         if length(peakIndex1)>2
%             start1 = peakIndex1(1);
%             end1 = peakIndex1(2);
%         else
%             start1 = peakIndex1(1);
%             end1 = peakIndex1(2);
%         end
        start1 = peakIndex2(index);
        end1 = peakIndex2(index+1);
%         [~,index11]=min(abs(peakIndex1-start1));
%         [~,index22]=min(abs(peakIndex1-end1));
%         start1 = peakIndex1(index11);
%         end1 = peakIndex1(index22);
        for fff_no=start1+2:end1+2
            image=imread(char(strcat(path3,fName3(fff_no))));
            if ~exist(char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/')),'dir')
                mkdir(char(strcat(save_path,fName1(f_no),'/',fName2(ff_no))));
            end
            imwrite(image,char(strcat(save_path,fName1(f_no),'/',fName2(ff_no),'/',fName3(fff_no))));
        end
    end
end

