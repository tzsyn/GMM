clear all;clc;
load 002
mx=mat;
k=5;
c=3;
cen=mx(:,k);
if c>1
    cen(c-1)=6;
end
[x,~]=find(cen>0&cen<5);
[y,~]=size(x);