clear all;clc;
load 002
% -------------------------------------------------------------------------
% 参数设定
% -------------------------------------------------------------------------
k1=8;
k2=12;
cone1_1=2;
cone1_2=4;
cone2_1=16;
cone2_2=13;
ban1=11;
ban2=12;
% -------------------------------------------------------------------------
a1=1;
b=1;
path=zeros(1,8);
% -------------------------------------------------------------------------
mat=mx(:,2:17);
a_mat=mat;
a_mx=mx;
% -------------------------------------------------------------------------
% 禁止的路径
% -------------------------------------------------------------------------
mat(ban1,ban2)=6;
mat(ban2,ban1)=6;
% -------------------------------------------------------------------------
% 进行整体遍历
% -------------------------------------------------------------------------
[g1,h1]=sk(mx,a1,0);
for i1=1:h1
    a2=g1(i1,1);
    [g2,h2]=sk(mat,a2,0);
    path(1)=g1(i1);
    for i2=1:h2
        a3=g2(i2,1);
        [g3,h3]=sk(mat,a3,a2);
        path(2)=g2(i2);
        for i3=1:h3
            a4=g3(i3,1);
            [g4,h4]=sk(mat,a4,a3);
            path(3)=g3(i3);
            for i4=1:h4
                a5=g4(i4,1);
                path(4)=g4(i4);
                if g4(i4)==17
                    path(5:end)=0;
                    rec{b}=path;
                    b=b+1;
                    continue
                end
                [g5,h5]=sk(mat,a5,a4);
                for i5=1:h5
                    a6=g5(i5,1);
                    path(5)=g5(i5);
                    if g5(i5)==17
                        path(6:end)=0;
                        rec{b}=path;
                        b=b+1;
                        continue
                    end
                    [g6,h6]=sk(mat,a6,a5);
                    for i6=1:h6
                        a7=g6(i6,1);
                        path(6)=g6(i6);
                        if g6(i6)==17
                            path(7:end)=0;
                             rec{b}=path;
                             b=b+1;
                             continue
                        end
                        [g7,h7]=sk(mat,a7,a6);
                        for i7=1:h7
                            a8=g7(i7,1);
                            path(7)=g7(i7);
                            if g7(i7)==17
                                path(8)=0;
                                rec{b}=path;
                                b=b+1;
                                continue
                            end
                            [g8,h8]=sk(mat,a8,a7);
                            for i8=1:h8
                                a9=g8(i8,1);
                                path(8)=g8(i8);
                                if g8(i8)==17
                                    rec{b}=path;
                                    b=b+1;
                                    continue
                                end
                                [g9,h9]=sk(mat,a9,a8);
                            end
                        end
                    end
                end
            end
        end
    end
end
% -------------------------------------------------------------------------
% 必须经过的储藏间
% -------------------------------------------------------------------------
[cc,dd]=size(rec);
record=zeros(dd,8);
for xx=1:dd
    [~,mm]=size(rec{xx});
    record(xx,1:mm)=rec{xx};
end
[p1,~]=find(record==5);
[ee1,~]=size(p1);
for j1=1:ee1
    record1(j1,:)=record(p1(j1),:);
end
[p2,~]=find(record1==12);
[ee2,~]=size(p2);
for j2=1:ee2
    record2(j2,:)=record1(p2(j2),:);
end
% -------------------------------------------------------------------------
% 必须经过的路径（1）
% -------------------------------------------------------------------------
w1=1;
for x1=1:ee2
    for y1=1:7
        if record2(x1,y1)==cone1_1&&record2(x1,y1+1)==cone1_2
            record3(w1,:)=record2(x1,:);
            w1=w1+1;
            continue
        end
    end
end
for x1=1:ee2
    for y1=1:7
        if record2(x1,y1)==cone1_2&&record2(x1,y1+1)==cone1_1
            record3(w1,:)=record2(x1,:);
            w1=w1+1;
            continue
        end
    end
end
% -------------------------------------------------------------------------
% 必须经过的路径（2）
% -------------------------------------------------------------------------
[ee3,~]=size(record3);
w2=1;
for x2=1:ee3
    for y2=1:7
        if record3(x2,y2)==cone2_1&&record3(x2,y2+1)==cone2_2
            record4(w2,:)=record3(x2,:);
            w2=w2+1;
            continue
        end
    end
end
for x2=1:ee3
    for y2=1:7
        if record3(x2,y2)==cone2_2&&record3(x2,y2+1)==cone2_1
            record4(w2,:)=record3(x2,:);
            w2=w2+1;
            continue
        end
    end
end
% -------------------------------------------------------------------------
% 筛选路径总合最小的路线
% -------------------------------------------------------------------------
if w2==1
    warndlg('没有找到');
else
[ee4,~]=size(record4);
stat=zeros(ee4,1);
for w=1:ee4
    for v=1:8
        if v==1
            tran=mx(record4(w,v),1);
            px{w}(v)=tran;
            stat(w)=stat(w)+tran;
        elseif record4(w,v)>0&&record4(w,v-1)>0
            tran=mx(record4(w,v),record4(w,v-1)+1);
            px{w}(v)=tran;
            stat(w)=stat(w)+tran;
        else
            break
        end
    end
end
[ss,sss]=min_r(stat);
[minp,~]=find(stat==ss);
ssss=zeros(sss,1);
for o=1:sss
    [~,ssss(o)]=size(px{minp(o)});
end
[tt,ttt]=min_r(ssss);
[minn,~]=find(ssss==tt);
if minn>=1
    for oo=1:minn
    disp([ '最小距离为: ' num2str(ss)]);
    disp([ '经过的储藏间数为: ' num2str(tt+1)]);
    disp(['经过的储藏间为: ','S点  ',num2str(record4(minp(minn(oo)),1:tt-1)),'  E点']);
    disp(['路径消耗为: ' num2str(px{minp(minn(oo))})]);
    end
end
end
