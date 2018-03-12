% =========================================================================
% 求多组特征矢量的均值和方差,更新了初始模型
% G_mix     初始模型
% x         数据
% Gmix      更新后的初始模型
% =========================================================================
function Gmix=Gmm_init(G_mix,x)
[e,x1,j]=kmeans(x,G_mix.n_Centres); 
% x1是一个向量,e是一个矩阵,j是一个向量
G_mix.Centres=x1;
GMM_WIDTH=1.00;
for m=1:G_mix.n_Centres
    k=find(e==m);   %找到与m最近的行的所有代号
    %------------------------------------------------------------
    Q=length(k);
    Q1=zeros(G_mix.n_Data,G_mix.n_Data);
    for j=1:Q
        temp=x(k(j),:)-x1(m,:); 
        % 这里只取了第一个与m值最近的k，但是这里的k一般是代表的一个向量
        Q1=temp'*temp+Q1;
    end
    G_mix.Covars(:,:,m)=Q1/Q;
    %---------------------------------------------------------------------------------------------
    %G_mix.Covars(:,:,m)=(temp.'*temp)/G_mix.n_Data;
    if rank(G_mix.Covars(:,:,m))<G_mix.n_Data
	   G_mix.Covars(:,:,m) = G_mix.Covars(:,:,m) + GMM_WIDTH.*eye(G_mix.n_Data);%rank:求秩
    end
end
Gmix=G_mix;              
