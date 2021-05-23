path1='H:\COFSI\CASIA_B\CASIA_B090degree_Centered_Alinged_one_cycle\';
list1 = dir(path1);
fName1 = {list1.name};
[~,y1]=size(fName1);
mid=double(0);
k=0;
path1

count1 = 0;
count2 = 0;
count3 = 0;
count4 = 0;
count5 = 0;
count6 = 0;
count7 = 0;
count8 = 0;
count9 = 0;
count0 = 0;
count10= 0;
count11= 0;
for f_no=3:y1
    path2=char(strcat(path1,fName1(f_no),'\'));
    list2 = dir(path2);
    fName2 = {list2.name};
    [~,y2]=size(fName2);
    fName1(f_no)
    for ff_no=7:y2
        path3= char(strcat(path1,fName1(f_no),'\',fName2(ff_no),'\'));
        list3 = dir(path3);
        fName3 = {list3.name};
        [~,y3]=size(fName3);        
        if y3-2==20
            count1 = count1+1;
        end
        if y3-2==21
            count2 = count2+1;
        end
        if y3-2==22
            count3 = count3+1;
        end
        if y3-2==23
            count4 = count4+1;
        end
        if y3-2==25
            count5 = count5+1;
        end    
        
        if y3-2==26
            count6 = count6+1;
        end
        if y3-2==27
            count7 = count7+1;
        end
        if y3-2==28
            count8 = count8+1;
        end
        if y3-2==29
            count9 = count9+1;
        end
        if y3-2==30
            count0 = count0+1;
        end    
        if y3-2==31
            count10 = count10+1;
        end
        if y3-2==32
            count11 = count11+1;
        end  
    end
end

count1
count2
count3
count4
count5

count6
count7
count8
count9
count0
count10
count11