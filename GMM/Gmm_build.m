% =========================================================================
% 说明：生成初始模型参数,全部随机产生
% dim    特征矢量维数
% m     高斯混合模型阶数
% =========================================================================
function Gmix=Gmm_build(dim,M)%%这里是生成初始模型参数,全部随机产生
if nargin<2
    M=16;   %即只输入一个变量，则M=16；
end
Gmix.type='gmm';
Gmix.n_Data=dim;
Gmix.n_Centres=M;
Gmix.W=ones(1,Gmix.n_Centres)./Gmix.n_Centres;
Gmix.Centres=randn(Gmix.n_Centres,Gmix.n_Data);
Gmix.Covars=repmat(eye(Gmix.n_Data),[1 1 Gmix.n_Centres]);