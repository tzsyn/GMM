clear all;clc;
load 002
% -------------------------------------------------------------------------
% 参数设定
% -------------------------------------------------------------------------
k1=5;
k2=12;
cone1_1=2;
cone1_2=4;
cone2_1=16;
cone2_2=13;
ban1=10;
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
ss=1;
[pa,pb]=size(record);
for i=1:pa
    for j=1:pb
        if record(i,j)==k1
            rec1{ss}=record(i,:);
            ss=ss+1;
            break;
        end
    end
end
[ccc,ddd]=size(rec1);
record1=zeros(ddd,8);
for xx=1:ddd
    [~,mm]=size(rec1{xx});
    record1(xx,1:mm)=rec1{xx};
end
