% =========================================================================
% em算法，生成一个GMM
% 其子程序包括 Gmm_post Gmm_rec
% G_mix     初始模型
% x         数据
% n_Loop    迭代次数次数
% limit     相对误差门限值
% =========================================================================
function Gmm_modle=Gmm_em(G_mix,x,n_Loop,limit)
if nargin<2
    error('a wrong input');
end
if nargin<3
    n_Loop=64;
end
[n_Frame,n_Data]=size(x);
if ~(n_Data==G_mix.n_Data)
    error('input new data');
end
MIN_COVAR=eps;
init_Covars=G_mix.Covars;
Loop=1;
while Loop<n_Loop
    
    %E_Step
    pre_post=Gmm_post(G_mix,x);%计算之前的后验概率；
    p=Gmm_rec(G_mix,x);
    %M_Step
    for k=1:G_mix.n_Centres
        
        temp1=ones(n_Frame,n_Data);
        z=ones(n_Frame,n_Data);
        Mtemp=ones(n_Data,n_Data,n_Frame);
        temp2=ones(n_Data,n_Data,n_Frame);
        
        %计算权系数
        G_mix.W(k)=sum(pre_post(k,:))/n_Frame;
        
        %计算均值中心
        for i=1:n_Frame
            temp1(i,:)=pre_post(k,i)*x(i,:);
        end
        G_mix.Centres(k,:)=sum(temp1)/(sum(pre_post(k,:))+realmin);
        
        %计算协方差矩阵
        for i=1:n_Frame
            z(i,:)=x(i,:)-G_mix.Centres(k,:);
            Mtemp(:,:,i)=(z(i,:))'*z(i,:);
        end
        for i=1:n_Frame
            temp2(:,:,i)=pre_post(k,i)*Mtemp(:,:,i);
        end
        
        G_mix.Covars(:,:,k)=sum(temp2,3)/(sum(pre_post(k,:))+realmin);
        
        %检验协方差矩阵的元素是否太小以至于无法继续迭代！
        %if rank(G_mix.Covars(:,:,k))<G_mix.n_Data
	      %G_mix.Covars(:,:,k) = G_mix.Covars(:,:,k) + 1.00.*eye(G_mix.n_Data);
        %end
%         if min(svd(G_mix.Covars(:,:,k))) < MIN_COVAR
        if min(svd(G_mix.Covars(:,:,k)+0.0001*eye(G_mix.n_Data))) <0.001

           %G_mix.Covars(:,:,k) = init_Covars(:,:,k);
           G_mix.Covars(:,:,k) = G_mix.Covars(:,:,k)+ 1*eye(G_mix.n_Data);
        end
    end
    p1=Gmm_rec(G_mix,x);
    %　p1-p
    if abs(p1-p)<limit
        break;
    else
        Loop=Loop+1;
    end
end
 Gmm_modle=G_mix;
        