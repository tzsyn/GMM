% =========================================================================
% ˵�������ɳ�ʼģ�Ͳ���,ȫ���������
% dim    ����ʸ��ά��
% m     ��˹���ģ�ͽ���
% =========================================================================
function Gmix=Gmm_build(dim,M)%%���������ɳ�ʼģ�Ͳ���,ȫ���������
if nargin<2
    M=16;   %��ֻ����һ����������M=16��
end
Gmix.type='gmm';
Gmix.n_Data=dim;
Gmix.n_Centres=M;
Gmix.W=ones(1,Gmix.n_Centres)./Gmix.n_Centres;
Gmix.Centres=randn(Gmix.n_Centres,Gmix.n_Data);
Gmix.Covars=repmat(eye(Gmix.n_Data),[1 1 Gmix.n_Centres]);