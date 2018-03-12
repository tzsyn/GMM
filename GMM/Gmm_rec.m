function prob=Gmm_rec(G_mix,x)
prob0=Gmm_b(G_mix,x);
%[a,b]=size(prob0);
[a,b]=size(x);
for i=1:a
    prob1(i)=G_mix.W*prob0(:,i);
end
prob=sum(log(prob1));