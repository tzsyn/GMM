% =========================================================================
% em�㷨������һ��GMM
% ���ӳ������ Gmm_post Gmm_rec
% G_mix     ��ʼģ��
% x         ����
% n_Loop    ������������
% limit     ����������ֵ
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
    pre_post=Gmm_post(G_mix,x);%����֮ǰ�ĺ�����ʣ�
    p=Gmm_rec(G_mix,x);
    %M_Step
    for k=1:G_mix.n_Centres
        
        temp1=ones(n_Frame,n_Data);
        z=ones(n_Frame,n_Data);
        Mtemp=ones(n_Data,n_Data,n_Frame);
        temp2=ones(n_Data,n_Data,n_Frame);
        
        %����Ȩϵ��
        G_mix.W(k)=sum(pre_post(k,:))/n_Frame;
        
        %�����ֵ����
        for i=1:n_Frame
            temp1(i,:)=pre_post(k,i)*x(i,:);
        end
        G_mix.Centres(k,:)=sum(temp1)/(sum(pre_post(k,:))+realmin);
        
        %����Э�������
        for i=1:n_Frame
            z(i,:)=x(i,:)-G_mix.Centres(k,:);
            Mtemp(:,:,i)=(z(i,:))'*z(i,:);
        end
        for i=1:n_Frame
            temp2(:,:,i)=pre_post(k,i)*Mtemp(:,:,i);
        end
        
        G_mix.Covars(:,:,k)=sum(temp2,3)/(sum(pre_post(k,:))+realmin);
        
        %����Э��������Ԫ���Ƿ�̫С�������޷�����������
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
    %��p1-p
    if abs(p1-p)<limit
        break;
    else
        Loop=Loop+1;
    end
end
 Gmm_modle=G_mix;
        