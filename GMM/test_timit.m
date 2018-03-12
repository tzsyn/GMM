% =========================================================================
% ���Խ���GMM
% =========================================================================
clc;clear all;
% -------------------------------------------------------------------------
sy_1=['D:\voice\TIMIT\1data\TRAIN\DR1\FCJF0\*.wav'];%dz����ַ��Ϊ����ȡ�õ�ַ�µ�������Ƶ�ļ�
dz_1=['D:\voice\TIMIT\1data\TRAIN\DR1\FCJF0\'];%������Ƶ�ĵ�ַ��Ϣ
wav_1=dir(sy_1);%������Ƶ���ļ�����������Ϣ
y1=[];
for j=1:9
    wjm_1=wav_1(j).name;%wjm���ļ�������Ƶ���ļ���
    sk_1{j}=[dz_1,wjm_1];%skΪ��ַ���ļ���һ�𹹳ɵ�cell
    [ssj,fs]=audioread(sk_1{j});%ssj��˫�������ݣ�������һ��˫��������Ƶ��ֻ��ȡһ�������ľͿ�����
    y_temp=mfcc(ssj,fs,512,256);
    y1=[y1;y_temp];
end
% -------------------------------------------------------------------------
sy_2=['D:\voice\TIMIT\1data\TRAIN\DR1\FDAW0\*.wav'];%dz����ַ��Ϊ����ȡ�õ�ַ�µ�������Ƶ�ļ�
dz_2=['D:\voice\TIMIT\1data\TRAIN\DR1\FDAW0\'];%������Ƶ�ĵ�ַ��Ϣ
wav_2=dir(sy_2);%������Ƶ���ļ�����������Ϣ
y2=[];
for j=1:9
    wjm_2=wav_2(j).name;%wjm���ļ�������Ƶ���ļ���
    sk_2{j}=[dz_2,wjm_2];%skΪ��ַ���ļ���һ�𹹳ɵ�cell
    [ssj,fs]=audioread(sk_2{j});%ssj��˫�������ݣ�������һ��˫��������Ƶ��ֻ��ȡһ�������ľͿ�����
    y_temp=mfcc(ssj,fs,512,256);
    y2=[y2;y_temp];
end
% -------------------------------------------------------------------------
% [x11,fs]=audioread('D:\voice\TIMIT\1data\TRAIN\DR1\FCJF0\SA1.wav');
% [x21,fs]=audioread('D:\voice\TIMIT\1data\TRAIN\DR1\FDAW0\SA1.wav');
[x3,fs]=audioread('D:\voice\TIMIT\1data\TRAIN\DR1\FCJF0\SX397.wav');
% y1=mfcc(x11,fs,512,256);
% y2=mfcc(x21,fs,512,256);
y3=mfcc(x3,fs,512,256);
% [e,i,j]=kmeans(y1,16);
% -------------------------------------------------------------------------
gmm_fomat=Gmm_build(12,16);
gmm_gai=Gmm_init(gmm_fomat,y1);
nb_num=64;
limit=0.0001;
Gmm_modlea1=Gmm_em(gmm_gai,y1,nb_num,limit);
% -------------------------------------------------------------------------
gmm_fomat=Gmm_build(12,16);
gmm_gai=Gmm_init(gmm_fomat,y2);
nb_num=64;
limit=0.0001;
Gmm_modlea2=Gmm_em(gmm_gai,y2,nb_num,limit);
% -------------------------------------------------------------------------
[a,b]=size(y3);
k=0;
for i=1:a
prob(i,1)=Gmm_rec(Gmm_modlea1,y3(i,:));
prob(i,2)=Gmm_rec(Gmm_modlea2,y3(i,:));
if prob(i,1)>=prob(i,2)
    k=k+1;
end
end
ss=k/a;     % ����ʶ������