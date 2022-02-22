%% present calcium imaging data and define the activity of cell on tone timebin definitions.
% 2022-02-10. Xinrong Wang
%%  loadData
clc
clear
dataname = 'E:\MATLAB\pl002\redata.csv';
data = importdata(dataname);
fs=20;
[mCells,nCells]=size(data);
period =1/fs:1/fs:mCells/fs;
time=reshape(period ,mCells,1);
%% Plot Cell activity curve
figure('Color',[1 1 1],...
    'OuterPosition',[415.4 235.4 574.4 507.2],'name','Cell activity curve ');% creat curve
% Add space between traces.
lacuna =8* std(data(:));
space = lacuna * ones(1, nCells);
space = cumsum(space);
hold('all');
x = repmat(time, 1, nCells);
y = bsxfun(@plus, space, data);
plot(x, y, 'LineWidth', 0.5, 'HandleVisibility', 'off');
set(gca, 'YTick', space, 'YTickLabel', 1:nCells,'FontName','Arial','FontSize',6,'FontWeight','bold','Layer','top',...
    'LineWidth',0.5,'XColor',[0 0 0],...
    'YColor',[0 0 0]);
xlim([0 mCells/fs]);
title('Cell activity during fear and extinction memory','FontSize',12,'FontWeight','bold'); 
%ylabel('Cell ID','FontWeight','bold','FontName','Arial');
xlabel('Time (s)','FontWeight','bold','FontName','Arial');
%% define cell activity during the peried of tone
% b=a(:,2:end);  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [m,n]=size(b);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
data_trans=data';
figure;imagesc(data_trans);    
data_s=sortrows(data_trans);    
figure;imagesc(data_s);
timewindons=20;
shartpoint=600;
%configuration = setDefault(configuration, 'artifactEpochs', []);
%zscore
data_std=std(data_trans,[],2);
data_zsc=(data_trans-mean(data_trans,2))./data_std;
data_tone=data_zsc(:,shartpoint-timewindons*fs:shartpoint+timewindons*fs);  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [m,idx]=max(data_tone,[],2);
% [max_cell,idx_cell]=sort(idx);
%
% data_sig=zeros(65,5701);
%
baseline_m=mean(data_tone(:,1:timewindons*fs)');
tone_m=mean(data_tone(:,timewindons*fs+1:timewindons*fs*2)');
ind_t=find(tone_m>=baseline_m);
cell_reduce=data_zsc(ind_t,1:timewindons*fs);
cell_increase=data_zsc(ind_t,timewindons*fs+1:timewindons*fs*2);
[m1,n1]=size(ind_t);
%ranksum test
for i=1:nCells
    
  [p1(i),h1(i),stats1(i)] = ranksum(data_zsc(i,1:timewindons*fs),data_zsc(i,timewindons*fs+1:timewindons*fs*2),'alpha', 0.05, 'tail', 'both')
  
end
ind_p=find(p1<0.05);
index=intersect(ind_t,ind_p);
cell=data_zsc(index,1:timewindons*fs*2);
cell_tone=data_zsc(index,timewindons*fs+1:timewindons*fs*2);
%cell_tone_example=data_zsc22(1990:3190,index);
[m2,n2]=size(index);
figure;imagesc(cell);    
hold on;line([timewindons*fs+1,timewindons*fs+1],[0,n2],'color','black');
%xlswrite('E:\MATLAB\pl012\pl012R_tone.xlsx', cell_tone)
baseline=data_zsc(:,1:timewindons*fs*2);
tone=data_zsc(:,timewindons*fs+1:timewindons*fs*2);
MR=mean(baseline');
ST=std(baseline');
thres =MR+1.5*ST;
acti=tone'>thres;
tone_binary=acti(:,index);
%% Save peak counts per epoch and cell to file.
cell_tone=cell_tone'
% [folder, basename] = fileparts(dataname);
% output = fullfile(folder, sprintf('%s - peak count.csv', basename));
% fid = fopen('E:\MATLAB\pl002\peak count.csv', 'w');
% % for ii=1:n2
% % fprintf(fid,'%d\t',cell_tone(ii,2));
% % fprintf(fid,'\n');
% % end
% %fprintf(fid,[C{[2*ones(1,n2) 2]}],cell_tone);
% fprintf(fid,[strjoin(repmat({'%d'}, 1, n2), ',\t') '\n'], cell_tone);
% %fprintf(fileID,[C{[ones(1) 2*ones(1,69) 3]}],xxx');
% fclose(fid);
csvwrite('E:\MATLAB\pl002\R44444.csv', cell_tone);
csvwrite('E:\MATLAB\pl002\wwwwwwww.csv', tone_binary);
%%