% =========================================================================
% ���������ʸ���ľ�ֵ�ͷ���,�����˳�ʼģ��
% G_mix     ��ʼģ��
% x         ����
% Gmix      ���º�ĳ�ʼģ��
% =========================================================================
function Gmix=Gmm_init(G_mix,x)
[e,x1,j]=kmeans(x,G_mix.n_Centres); 
% x1��һ������,e��һ������,j��һ������
G_mix.Centres=x1;
GMM_WIDTH=1.00;
for m=1:G_mix.n_Centres
    k=find(e==m);   %�ҵ���m������е����д���
    %------------------------------------------------------------
    Q=length(k);
    Q1=zeros(G_mix.n_Data,G_mix.n_Data);
    for j=1:Q
        temp=x(k(j),:)-x1(m,:); 
        % ����ֻȡ�˵�һ����mֵ�����k�����������kһ���Ǵ����һ������
        Q1=temp'*temp+Q1;
    end
    G_mix.Covars(:,:,m)=Q1/Q;
    %---------------------------------------------------------------------------------------------
    %G_mix.Covars(:,:,m)=(temp.'*temp)/G_mix.n_Data;
    if rank(G_mix.Covars(:,:,m))<G_mix.n_Data
	   G_mix.Covars(:,:,m) = G_mix.Covars(:,:,m) + GMM_WIDTH.*eye(G_mix.n_Data);%rank:����
    end
end
Gmix=G_mix;              
