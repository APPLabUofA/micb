%% Include colour differentiation of soa



% This script is designed to characterize incorrect gabors
% 1) compare the position of the correct versus incorrect on inaccurate trials 
% gabor on a) direction b) control vs experimental trials, and b) different
% SOA buckets
%2) compare orientation of incorrect and gabors with correct and
%surrounding gabors, as well as contrasting to correct gabor neighbours

%%

% ccc
lengthy = 240;
Gabor_List = 1:8;	

sub_nums = {'000', '001', '002', '003', '004', '005', '006', '007',...
			'008', '009', '010', '011', '012'};
		
nsubs = length(sub_nums);

ColorMap1 = containers.Map({-7,-5,-3,-1,0,1,3,5,7},{[230/255 25/255 75/255],[245/255 130/255 48/255],[255/255 225/255 25/255],[210/255 245/255 60/255],[0 0 0],[70/255 240/255 240/255],[0 130/255 200/255],[145/255 30/255 180/255],[240/255 50/255 230/255]});
% ColorMap = [[230 25 75],[245 130 48],[255 225 25],[210 245 60],[0 0 0],[70 240 240],[0 130 200],[145 30 180],[240 50 230]];
ColorMap2 = containers.Map({-7,-5,-3,-1,0,1,3,5,7},{[0.1 0.1 0.1];[0.2 0.2 0.2];[0.3 0.3 0.3];[0.4 0.4 0.4];[0.5 0.5 0.5];[0.6 0.6 0.6];[0.7 0.7 0.7];[0.8 0.8 0.8 ];[0.9 0.9 0.9]});
ColorMap3 = containers.Map({-7,-5,-3,-1,0,1,3,5,7},{[1 0.1 0.1];[1 0.2 0.2];[1 0.3 0.3];[1 0.4 0.4];[1 0.5 0.5];[1 0.6 0.6];[1 0.7 0.7];[1 0.8 0.8 ];[1 0.9 0.9]});
ColorMap4 = containers.Map({-7,-5,-3,-1,0,1,3,5,7},{[0.1 0.1 1];[0.2 0.2 1];[0.3 0.3 1];[0.4 0.4 1];[0.5 0.5 1];[0.6 0.6 1];[0.7 0.7 1];[0.8 0.8 1];[0.9 0.9 1]});

cmap1 = [[230/255 25/255 75/255];[245/255 130/255 48/255];[255/255 225/255 25/255];[210/255 245/255 60/255];[0 0 0];[70/255 240/255 240/255];[0 130/255 200/255];[145/255 30/255 180/255];[240/255 50/255 230/255]];
cmap2 = [[0.1 0.1 0.1];[0.2 0.2 0.2];[0.3 0.3 0.3];[0.4 0.4 0.4];[0.5 0.5 0.5];[0.6 0.6 0.6];[0.7 0.7 0.7];[0.8 0.8 0.8 ];[0.9 0.9 0.9]];
cmap3 = [[1 0.1 0.1];[1 0.2 0.2];[1 0.3 0.3];[1 0.4 0.4];[1 0.5 0.5];[1 0.6 0.6];[1 0.7 0.7];[1 0.8 0.8 ];[1 0.9 0.9]];
cmap4 = [[0.1 0.1 1];[0.2 0.2 1];[0.3 0.3 1];[0.4 0.4 1];[0.5 0.5 1];[0.6 0.6 1];[0.7 0.7 1];[0.8 0.8 1];[0.9 0.9 1]];
cmap5 = [[1 0.3 0.3];[1 0.5 0.5];[1 0.7 0.7];[1 0.9 0.9]];
lbl = {'-7','-5','-3','-1','0','1','3','5','7'};

%% Incorrect trial gabor distances as a function of SOA

figure('Position',[25,25,1500,800]); 
widthHeight = ceil(sqrt(nsubs));


for i_subs = 1:nsubs
    count = 0; count_x = 0;
    current_sub = sub_nums{i_subs};
    
    par_str1(i_subs).Incor = zeros(6,lengthy);


    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);
    
    if i_subs == 1
        SOA_dist_group = zeros(nsubs,length(soas));
        SOA_dist_mean = length(soas);
        SOA_dist_std = length(soas);
    end
        
    for i = 1:length(par_str1(i_subs).Incor)
        if isnan(out_incorrect_gabor(i)) ~= true
            count = count + 1;
            par_str1(i_subs).Incor(1,count) = i; par_str1(i_subs).Incor_L(2,count) = out_incorrect_gabor(i);
            par_str1(i_subs).Incor(3,count) = trialList(i,1);
            normDeg = mod(par_str1(i_subs).Incor(2,count) - par_str1(i_subs).Incor(3,count),8);
            par_str1(i_subs).Incor(4,count) = min(8-normDeg, normDeg);
            par_str1(i_subs).Incor(5,count) = out_RT(i);
            par_str1(i_subs).Incor(6,count) = out_soa(i);
        end
    end
    for ii = 1:length(soas)
        SOA_dist_mean(ii) = mean(par_str1(i_subs).Incor(5,par_str1(i_subs).Incor(6,1:count) == soas(ii)));
        SOA_dist_std(ii) = std(par_str1(i_subs).Incor(5,par_str1(i_subs).Incor(6,1:count) == soas(ii)));
    end
    subplot(widthHeight,widthHeight,i_subs); 
    errorbar(soas,SOA_dist_mean,SOA_dist_std,'r'); 
%         legend({'Distance'});
        xlim([min(soas) max(soas)]); 
        set(gca,'XTick',min(soas):1:max(soas))
        xlabel('Gabor First < -- SOA (frames) -- > Gabor After')
        ylabel('Incorrect Gabor Distance')
        ylim([.01 4])
        title(current_sub)
    SOA_dist_group(i_subs,:) = SOA_dist_mean;
end

figure;
	errorbar(soas, mean(SOA_dist_group,1), std(SOA_dist_group,[],1) / sqrt(nsubs),'r');
% 	legend({'Flexion','Control'});
    xlim([min(soas) max(soas)]); 
    set(gca,'XTick',min(soas):1:max(soas))
    xlabel('Gabor First < -- SOA (frames) -- > Gabor After')
    ylabel('Incorrect Gabor Distance')
    ylim([.6 1.5])
	title('Grand Average')

