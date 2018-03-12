function Postprob=Gmm_post(G_mix,x)%%这个是求后验概率的函数
[n_Frame,n_Data]=size(x);
 if ~(n_Data==G_mix.n_Data)
     error('please input new datas');
 end
Common=(2*pi)^((G_mix.n_Data)/2);
b=ones(G_mix.n_Centres,n_Frame);
Postprob=ones(G_mix.n_Centres,n_Frame);
Postprob=1.00000000*Postprob;
for m=1:G_mix.n_Centres
    for t=1:n_Frame
        temp=ones(G_mix.n_Centres,G_mix.n_Centres);
        diffs=x(t,:)-G_mix.Centres(m,:);
        %temp=inv(G_mix.Covars(:,:,m));
        %n=-0.5*(diffs*temp*diffs.');
        %d=det(temp);
%         c=chol(G_mix.Covars(:,:,m));
%         temp=diffs/c;
%         n=-0.5*(temp*temp.');
%         d=prod(diag(c));
%         b(m,t)=exp(n)/(Common*(d^0.5));
        n=inv(G_mix.Covars(:,:,m))+1*eye(G_mix.n_Data);
        d=abs(det(G_mix.Covars(:,:,m)));
        b(m,t)=exp(-0.5*diffs*n*diffs')/Common*d^0.5;
    end
end
for m=1:G_mix.n_Centres
    for t=1:n_Frame
        Postprob(m,t)=(G_mix.W(m)*b(m,t))/((G_mix.W*b(:,t))+realmin);%第t帧数据在第k个高斯分量上的后验概率
    end
end
        