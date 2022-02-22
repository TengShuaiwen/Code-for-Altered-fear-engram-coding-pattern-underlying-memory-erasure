function Wi=cellstrength(data)
% This function recieves the co-firing strength which was the total weight of edges per node. 
% Inputs:
% 1. Edge weights between nodes

% Outputs:
% 1.co-firing strength 

%2021.08.07  Xinrong Wang
data_label=data(:,1);%label
data_edge=data(:,7);%weight
[dupNames, dupNdxs] = getDuplicates(data_label) 
[m,n]=size(dupNdxs)
result=zeros(1,m);  
for i=1:m
w=dupNdxs{i};
o=data_edge(w)
q=sum(o)
result(1,i)=q
end
Wi=result;
end
%q=cell2mat{cell(i,1))};
