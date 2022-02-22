function coradj=corr_adj_matrix(data_t)
% calculate the correlation between cells to receive the correlation matrix 
[m,n]=size(data_t);
[r,P] = corrcoef(data_t);
%r1=R;
r(r==1)=0;
a=nanmean(nanmean(r));
r(isnan(r))=a;
P(isnan(P))=a;
r(r<=0.1)=0;
ind1=find(P>0.05); 
r(ind1)=0;
coradj=r;
end



