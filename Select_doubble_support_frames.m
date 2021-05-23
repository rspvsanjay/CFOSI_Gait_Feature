path='H:\CASIA_B\CASIA_B090degree_Centered_Alinged\';
list = dir(path);
fName = {list.name};
[~,y1]=size(fName);
path
y1
tic;
% sumimage = double(zeros([128,128]));
sumimage = double(zeros([256,256]));
for f_no=3:32%y1
    listin = dir(char(strcat(path,fName(f_no),'\')));
    fNamein = {listin.name};
    [~,y2]=size(fNamein);
    fName(f_no)
    for ff_no=7:y2
        path2 = char(strcat(path,fName(f_no),'\',fNamein(ff_no),'\'));
        listinin = dir(path2);
        fNameinin = {listinin.name};
        [~,y3]=size(fNameinin);
        arr = [];
        for fff_no=3:y3
            image=imread(char(strcat(path2,fNameinin(fff_no))));
            arr = [arr,length(nonzeros(image))];
        end
        [max1,index]=max(arr);
        image=double(imread(char(strcat(path2,fNameinin(index+2)))));
        max1 = max(image(:));
        image = image/max1;
        sumimage = sumimage + image;
        %         imwrite(image,char(strcat(save_path,int2str(count),'.png')));
        %         count = count + 1;
    end
end
max1 = max(sumimage(:));
sumimage = sumimage/max1;
imwrite(sumimage,char(strcat('H:\COFSI\CASIA_B\','double_support.png')));
figure,imshow(sumimage);