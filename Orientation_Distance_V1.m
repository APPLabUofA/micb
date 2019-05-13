%% Include colour differentiation of soa



% This script is designed to characterize incorrect gabors
% 1) compare the position of the correct versus incorrect on inaccurate trials 
% gabor on a) direction b) control vs experimental trials, and b) different
% SOA buckets
%2) compare orientation of incorrect and gabors with correct and
%surrounding gabors, as well as contrasting to correct gabor neighbours

%%

ccc
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
%% Looking at the incorrect gabor distances as a function of direction
% Bubble or boxplots w distance from median as color
% Plot incorrect gabor distance against SOA 

figure('Position',[25,25,1900,1100]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count1 = 0; count2 = 0;
    current_sub = sub_nums{i_subs};
    
    par_str1(i_subs).Incor_L = zeros(6,lengthy);
    par_str1(i_subs).Incor_R = zeros(6,lengthy);

    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);

    for i = 1:length(par_str1(i_subs).Incor_L)
        if isnan(out_incorrect_gabor(i)) ~= true
            if out_direction(i) == 0
                count1 = count1 + 1;
                par_str1(i_subs).Incor_L(1,count1) = i; par_str1(i_subs).Incor_L(2,count1) = out_incorrect_gabor(i);
                par_str1(i_subs).Incor_L(3,count1) = trialList(i,1);
                normDeg = mod(par_str1(i_subs).Incor_L(2,count1) - par_str1(i_subs).Incor_L(3,count1),8);
                par_str1(i_subs).Incor_L(4,count1) = min(8-normDeg, normDeg);
                par_str1(i_subs).Incor_L(5,count1) = out_RT(i);
                par_str1(i_subs).Incor_R(6,count1) = out_soa(i);
            elseif out_direction(i) == 1
                count2 = count2 + 1;
                par_str1(i_subs).Incor_R(1,count2) = i; par_str1(i_subs).Incor_R(2,count2) = out_incorrect_gabor(i);
                par_str1(i_subs).Incor_R(3,count2) = trialList(i,1);
                normDeg = mod(par_str1(i_subs).Incor_R(2,count2) - par_str1(i_subs).Incor_R(3,count2),8);
                par_str1(i_subs).Incor_R(4,count2) = min(8-normDeg, normDeg);
                par_str1(i_subs).Incor_R(5,count2) = out_RT(i);
                par_str1(i_subs).Incor_R(6,count2) = out_soa(i);
            end
        end
    end
    
    par_str1(i_subs).Incor_L_Count = count1;
    par_str1(i_subs).Incor_L_Sum = sum(par_str1(i_subs).Incor_L(4,:));
    par_str1(i_subs).Incor_L_Weighted = par_str1(i_subs).Incor_L_Sum/count1;
    par_str1(i_subs).Incor_L_std = std(par_str1(i_subs).Incor_L(4,:));

    par_str1(i_subs).Incor_R_Count = count2;
    par_str1(i_subs).Incor_R_Sum = sum(par_str1(i_subs).Incor_R(4,:));
    par_str1(i_subs).Incor_R_Weighted = par_str1(i_subs).Incor_R_Sum/count2;
    par_str1(i_subs).Incor_R_std = std(par_str1(i_subs).Incor_R(4,:));
    
    subplot(widthHeight,widthHeight,i_subs); 
        hold on
        for i_point=1:count1
            plot(par_str1(i_subs).Incor_L(4,:),par_str1(i_subs).Incor_L(5,:),'sk','markersize',6,'markerfacecolor',ColorMap3(par_str1(i_subs).Incor_L(6,i_point)))        
        end
        for i_point=1:count2
            plot(par_str1(i_subs).Incor_R(4,:),par_str1(i_subs).Incor_R(5,:),'sk','markersize',6,'markerfacecolor',ColorMap3(par_str1(i_subs).Incor_R(6,i_point)))
        end
        for ii = 1:size(cmap1,1)
            p(ii) = patch(NaN, NaN, cmap3(ii,:));
        end
        legend(p, lbl,'Location', 'northeastoutside');
        xlim([0 max(Gabor_List/2+1)]); 
        set(gca,'XTick',min(Gabor_List):1:max(Gabor_List))
        xlabel('Incorrect Gabor Distance')
        ylabel('Reaction Time (s)')
        xticks(1:4)
        ylim([.01 2])
        title(current_sub)
end

suptitle('Incorrect Gabor Distance to Correct vs. RT - Left (Red) Right (Blue) - Shade Indicates SOA')
hold off

Dir_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Dir_Diff_Mean(i) = par_str1(i).Incor_L_Weighted - par_str1(i).Incor_R_Weighted;
end
Dir_Diff_GA = mean(Dir_Diff_Mean);
Dir_Diff_SE = std(Dir_Diff_Mean);

%% Looking at the incorrect trial gabor distances as a function of condition
% Maybe don't use incorrect control trials?

figure('Position',[25,25,1900,1100]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count1 = 0; count2 = 0;
    current_sub = sub_nums{i_subs};
    
    par_str2(i_subs).Incor_Con = zeros(6,lengthy);
    par_str2(i_subs).Incor_Exp = zeros(6,lengthy);

    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);

    for i = 1:lengthy
        if isnan(out_incorrect_gabor(i)) ~= true 
            if trialList(i,3) == 0
                count1 = count1 + 1;
                par_str2(i_subs).Incor_Con(1,count1) = i; par_str2(i_subs).Incor_Con(2,count1) = out_incorrect_gabor(i);
                par_str2(i_subs).Incor_Con(3,count1) = trialList(i,1);
                normDeg = mod(par_str2(i_subs).Incor_Con(2,count1) - par_str2(i_subs).Incor_Con(3,count1),8);
                par_str2(i_subs).Incor_Con(4,count1) = min(8-normDeg, normDeg);
                par_str2(i_subs).Incor_Con(5,count1) = out_RT(i);
                par_str2(i_subs).Incor_Con(6,count1) = out_soa(i);
            else
                count2 = count2 + 1;
                par_str2(i_subs).Incor_Exp(1,count2) = i; par_str2(i_subs).Incor_Exp(2,count2) = out_incorrect_gabor(i);
                par_str2(i_subs).Incor_Exp(3,count2) = trialList(i,1);
                normDeg = mod(par_str2(i_subs).Incor_Exp(2,count2) - par_str2(i_subs).Incor_Exp(3,count2),8);
                par_str2(i_subs).Incor_Exp(4,count2) = min(8-normDeg, normDeg);
                par_str2(i_subs).Incor_Exp(5,count2) = out_RT(i);
                par_str2(i_subs).Incor_Exp(6,count2) = out_soa(i);
            end
        end
    end

    par_str2(i_subs).Incor_Con_Count = count1;
    par_str2(i_subs).Incor_Con_Sum = sum(par_str2(i_subs).Incor_Con(4,:));
    par_str2(i_subs).Incor_Con_Weighted = par_str2(i_subs).Incor_Con_Sum/count1;
    par_str2(i_subs).Incor_Con_std = std(par_str2(i_subs).Incor_Con(4,:));

    par_str2(i_subs).Incor_Con_Count = count2;
    par_str2(i_subs).Incor_Exp_Sum = sum(par_str2(i_subs).Incor_Exp(4,:));
    par_str2(i_subs).Incor_Exp_Weighted = par_str2(i_subs).Incor_Exp_Sum/count2;
    par_str2(i_subs).Incor_Exp_std = std(par_str2(i_subs).Incor_Con(4,:));

    subplot(widthHeight,widthHeight,i_subs); 
        hold on
        for i_point=1:count1
            plot(par_str2(i_subs).Incor_Con(4,i_point),par_str2(i_subs).Incor_Con(5,i_point),'sk','markersize',6,'markerfacecolor',ColorMap3(par_str2(i_subs).Incor_Con(6,i_point)))
        end
        for i_point=1:count2
            plot(par_str2(i_subs).Incor_Exp(4,i_point),par_str2(i_subs).Incor_Exp(5,i_point),'sk','markersize',6,'markerfacecolor',ColorMap4(par_str2(i_subs).Incor_Exp(6,i_point)))
        end
        for ii = 1:size(cmap1,1)
            p(ii) = patch(NaN, NaN, cmap3(ii,:));
        end
        legend(p, lbl,'Location', 'northeastoutside');
        xlim([0 max(Gabor_List/2+1)]); 
        set(gca,'XTick',min(Gabor_List):1:max(Gabor_List))
        xlabel('Incorrect Gabor Distance')
        ylabel('Reaction Time (s)')
        ylim([.01 2])
        title(current_sub)            
end

suptitle('Incorrect Gabor Distance to Correct vs. RT - Control Condition (Red) Experiment Condition (Blue) - Shade Indicates SOA')
hold off

Cond_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Cond_Diff_Mean(i) = par_str2(i).Incor_Con_Weighted - par_str2(i).Incor_Exp_Weighted;
end
Cond_Diff_GA = mean(Cond_Diff_Mean);
Cond_Diff_SE = std(Cond_Diff_Mean);

%% Looking at the incorrect trial gabor orientation as a function of counterclockwise and clockwise gabor orientations
%line plot - Incorrect Gabor Diff as the y-axis and SOAs as x axis - median
%or mean
%at each SOA

figure('Position',[25,25,1900,1100]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count = 0;
    current_sub = sub_nums{i_subs};
    
    par_str3(i_subs).Orient_F = zeros(9,lengthy);

    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);

    for i = 1:lengthy
        if isnan(out_incorrect_gabor(i)) ~= true 
            count = count + 1;
            par_str3(i_subs).Orient_F(1,count) = i; par_str3(i_subs).Orient_F(2,count) = out_incorrect_gabor(i); % pull out index and value of incorrect gabor
            if par_str3(i_subs).Orient_F(2,count) == 1
                lower = 8;
            else 
                lower = par_str3(i_subs).Orient_F(2,count)-1;
            end
            if par_str3(i_subs).Orient_F(2,count) == 8
                upper = 1;
            else
                upper = par_str3(i_subs).Orient_F(2,count)+1;
            end
            par_str3(i_subs).Orient_F(5,count) = out_rotation{i}(par_str3(i_subs).Orient_F(2,count)); % incorrect gabor
            par_str3(i_subs).Orient_F(3,count) = out_rotation{i}(lower); % counterclockwise 1 position of incorrect gabor
            normDeg = mod(par_str3(i_subs).Orient_F(3,count) - par_str3(i_subs).Orient_F(5,count),360);
            par_str3(i_subs).Orient_F(4,count) = min(360-normDeg, normDeg);
            par_str3(i_subs).Orient_F(7,count) = out_rotation{i}(upper); % clockwise 1 position of inccorect gabor
            normDeg = mod(par_str3(i_subs).Orient_F(7,count) - par_str3(i_subs).Orient_F(5,count),360);
            par_str3(i_subs).Orient_F(6,count) = min(360-normDeg, normDeg);
            par_str3(i_subs).Orient_F(8,count) = out_RT(i);
            par_str3(i_subs).Orient_F(9,count) = out_soa(i);
        end
    end
    
    par_str3(i_subs).Orient_Count = count;
    
    par_str3(i_subs).Orient_F_L_Sum = sum(par_str3(i_subs).Orient_F(4,:));
    par_str3(i_subs).Orient_F_L_Weighted = par_str3(i_subs).Orient_F_L_Sum/count;
    par_str3(i_subs).Orient_F_L_std = std(par_str3(i_subs).Orient_F(4,:));

    par_str3(i_subs).Orient_F_R_Sum = sum(par_str3(i_subs).Orient_F(6,:));
    par_str3(i_subs).Orient_F_R_Weighted = par_str3(i_subs).Orient_F_R_Sum/count;
    par_str3(i_subs).Orient_F_R_std = std(par_str3(i_subs).Orient_F(6,:));
    
    subplot(widthHeight,widthHeight,i_subs); 
        hold on 
        for i_point=1:count
            plot(par_str3(i_subs).Orient_F(4,i_point),par_str3(i_subs).Orient_F(8,i_point),'sk','markersize',7,'markerfacecolor',ColorMap3(par_str3(i_subs).Orient_F(9,i_point)))
            plot(par_str3(i_subs).Orient_F(6,i_point),par_str3(i_subs).Orient_F(8,i_point),'sk','markersize',7,'markerfacecolor',ColorMap4(par_str3(i_subs).Orient_F(9,i_point)))
        end
        for ii = 1:size(cmap1,1)
            p(ii) = patch(NaN, NaN, cmap3(ii,:));
        end
        legend(p, lbl,'Location', 'northeastoutside');
        xlim([0 180]); 
        ylim([.3 1.5])
        set(gca,'XTick',0:20:180)
        xlabel('Incorrect Gabor Orientation Diff (°)')
        ylabel('Reaction Time (s)')
        title(current_sub)
end

suptitle('Incorrect Gabor Orientation Diff to Adjacent vs. RT - Counterclockwise (Red) Clockwise (Blue) - Shade Indicates SOA')
hold off

Ori_F_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_F_Diff_Mean(i) = par_str3(i).Orient_F_L_Weighted - par_str3(i).Orient_F_R_Weighted;
end
Ori_F_Diff_GA = mean(Ori_F_Diff_Mean);
Ori_F_Diff_SE = std(Ori_F_Diff_Mean);


%% 
%% Looking at the incorrect trial gabor orientation as a function of surrounding gabor orientation (ignoring side)

figure('Position',[25,25,1900,1100]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count = 0;
    current_sub = sub_nums{i_subs};
    
    par_str3(i_subs).Orient_F = zeros(9,lengthy);

    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);

    for i = 1:lengthy
        if isnan(out_incorrect_gabor(i)) ~= true 
            count = count + 1;
            par_str3(i_subs).Orient_F(1,count) = i; par_str3(i_subs).Orient_F(2,count) = out_incorrect_gabor(i); % pull out index and value of incorrect gabor
            if par_str3(i_subs).Orient_F(2,count) == 1
                lower = 8;
            else 
                lower = par_str3(i_subs).Orient_F(2,count)-1;
            end
            if par_str3(i_subs).Orient_F(2,count) == 8
                upper = 1;
            else
                upper = par_str3(i_subs).Orient_F(2,count)+1;
            end
            par_str3(i_subs).Orient_F(5,count) = out_rotation{i}(par_str3(i_subs).Orient_F(2,count)); % incorrect gabor
            par_str3(i_subs).Orient_F(3,count) = out_rotation{i}(lower); % counterclockwise 1 position of incorrect gabor
            normDeg = mod(par_str3(i_subs).Orient_F(3,count) - par_str3(i_subs).Orient_F(5,count),360);
            par_str3(i_subs).Orient_F(4,count) = min(360-normDeg, normDeg);
            par_str3(i_subs).Orient_F(7,count) = out_rotation{i}(upper); % clockwise 1 position of inccorect gabor
            normDeg = mod(par_str3(i_subs).Orient_F(7,count) - par_str3(i_subs).Orient_F(5,count),360);
            par_str3(i_subs).Orient_F(6,count) = min(360-normDeg, normDeg);
            par_str3(i_subs).Orient_F(8,count) = out_RT(i);
            par_str3(i_subs).Orient_F(9,count) = out_soa(i);
        end
    end
    
    par_str3(i_subs).Orient_Count = count;
    
    par_str3(i_subs).Orient_F_L_Sum = sum(par_str3(i_subs).Orient_F(4,:));
    par_str3(i_subs).Orient_F_L_Weighted = par_str3(i_subs).Orient_F_L_Sum/count;
    par_str3(i_subs).Orient_F_L_std = std(par_str3(i_subs).Orient_F(4,:));

    par_str3(i_subs).Orient_F_R_Sum = sum(par_str3(i_subs).Orient_F(6,:));
    par_str3(i_subs).Orient_F_R_Weighted = par_str3(i_subs).Orient_F_R_Sum/count;
    par_str3(i_subs).Orient_F_R_std = std(par_str3(i_subs).Orient_F(6,:));
    
    subplot(widthHeight,widthHeight,i_subs);
        hold on
        for i_point=1:count
            plot(par_str3(i_subs).Orient_F(4,i_point),par_str3(i_subs).Orient_F(8,i_point),'sk','markersize',8,'markerfacecolor',ColorMap3(par_str3(i_subs).Orient_F(9,i_point)))
            plot(par_str3(i_subs).Orient_F(6,i_point),par_str3(i_subs).Orient_F(8,i_point),'sk','markersize',8,'markerfacecolor',ColorMap3(par_str3(i_subs).Orient_F(9,i_point)))
        end
        for ii = 1:size(cmap1,1)
            p(ii) = patch(NaN, NaN, cmap3(ii,:));
        end
        legend(p, lbl,'Location', 'northeastoutside');
        xlim([0 180]); 
        ylim([.3 1.5])
        set(gca,'XTick',0:20:180)
        xlabel('Incorrect Gabor Orientation Diff (°)')
        ylabel('Reaction Time (s)')
        title(current_sub)
end

suptitle('Incorrect Gabor Orientation Diff to Adjacent vs. RT - Shade Indicates SOA')
hold off

Ori_F_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_F_Diff_Mean(i) = par_str3(i).Orient_F_L_Weighted - par_str3(i).Orient_F_R_Weighted;
end
Ori_F_Diff_GA = mean(Ori_F_Diff_Mean);
Ori_F_Diff_SE = std(Ori_F_Diff_Mean);


%% Looking at correct trial gabor orientation as a function of counter_clockwise and clockwise gabor orientations

figure('Position',[25,25,1900,1100]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count = 0;
    current_sub = sub_nums{i_subs};
    
    par_str4(i_subs).Orient_T = zeros(8,lengthy);

    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);

    for i = 1:lengthy
        if isnan(out_incorrect_gabor(i)) ~= true 
            count = count + 1;
            par_str4(i_subs).Orient_T(1,count) = i; par_str4(i_subs).Orient_T(2,count) = out_incorrect_gabor(i); % pull out index and value of incorrect gabor
            if par_str4(i_subs).Orient_T(2,count) == 1
                lower = 8;
            else 
                lower = par_str4(i_subs).Orient_T(2,count)-1;
            end
            if par_str4(i_subs).Orient_T(2,count) == 8
                upper = 1;
            else
                upper = par_str4(i_subs).Orient_T(2,count)+1;
            end
            par_str4(i_subs).Orient_T(5,count) = out_rotation{i}(par_str4(i_subs).Orient_T(2,count)); % incorrect gabor
            par_str4(i_subs).Orient_T(3,count) = out_rotation{i}(lower); % counterclockwise 1 position of incorrect gabor
            normDeg = mod(par_str4(i_subs).Orient_T(3,count) - par_str4(i_subs).Orient_T(5,count),360);
            par_str4(i_subs).Orient_T(4,count) = min(360-normDeg, normDeg);
            par_str4(i_subs).Orient_T(7,count) = out_rotation{i}(upper); % clockwise 1 position of inccorect gabor
            normDeg = mod(par_str4(i_subs).Orient_T(7,count) - par_str4(i_subs).Orient_T(5,count),360);
            par_str4(i_subs).Orient_T(6,count) = min(360-normDeg, normDeg);
            par_str4(i_subs).Orient_T(8,count) = out_RT(i);
            par_str4(i_subs).Orient_T(9,count) = out_soa(i);

        end
    end
    par_str4(i_subs).Orient_Count = count;
    
    par_str4(i_subs).Orient_T_L_Sum = sum(par_str4(i_subs).Orient_T(4,:));
    par_str4(i_subs).Orient_T_L_Weighted = par_str4(i_subs).Orient_T_L_Sum/count;
    par_str4(i_subs).Orient_T_L_std = std(par_str4(i_subs).Orient_T(4,:));

    par_str4(i_subs).Orient_T_R_Sum = sum(par_str4(i_subs).Orient_T(6,:));
    par_str4(i_subs).Orient_T_R_Weighted = par_str4(i_subs).Orient_T_R_Sum/count;
    par_str4(i_subs).Orient_T_R_std = std(par_str4(i_subs).Orient_T(6,:)); 
    
    subplot(widthHeight,widthHeight,i_subs); 
        hold on
        for i_point=1:count
          plot(par_str4(i_subs).Orient_T(4,i_point), par_str4(i_subs).Orient_T(8,i_point),'sk','markersize',8,'markerfacecolor',ColorMap3(par_str4(i_subs).Orient_T(9,i_point)));
          plot(par_str4(i_subs).Orient_T(6,i_point), par_str4(i_subs).Orient_T(8,i_point),'sk','markersize',8,'markerfacecolor',ColorMap4(par_str4(i_subs).Orient_T(9,i_point)));
        end
        for ii = 1:size(cmap1,1)*2
            if ii <= size(cmap1,1)
                p(ii) = patch(NaN, NaN, cmap3(ii,:));
            else
                p(ii) = patch(NaN, NaN, cmap4(ii-9,:));
            end
        end
        legend(p, lbl,'Location', 'northeastoutside');
        xlim([0 180]); 
        ylim([.3 1.5])
        set(gca,'XTick',0:20:180)
        xlabel('Incorrect Gabor Orientation Diff (°)')
        ylabel('Reaction Time (s)')
        title(current_sub)
end

suptitle('Correct Gabor Orientation Diff to Adjacent vs. RT - Counterclockwise (Red) Clockwise (Blue) - Shade Indicates SOA')

Ori_T_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_T_Diff_Mean(i) = par_str4(i).Orient_T_L_Weighted - par_str4(i).Orient_T_R_Weighted;
end
Ori_T_Diff_GA = mean(Ori_T_Diff_Mean);
Ori_T_Diff_SE = std(Ori_T_Diff_Mean);

%% Looking at correct trial gabor orientation as a function of surrounding gabor orientation (ignoring side)

figure('Position',[25,25,1900,1100]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count = 0;
    current_sub = sub_nums{i_subs};
    
    par_str4(i_subs).Orient_T = zeros(9,lengthy);

    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);

    for i = 1:lengthy
        if isnan(out_incorrect_gabor(i)) ~= true 
            count = count + 1;
            par_str4(i_subs).Orient_T(1,count) = i; par_str4(i_subs).Orient_T(2,count) = out_incorrect_gabor(i); % pull out index and value of incorrect gabor
            if par_str4(i_subs).Orient_T(2,count) == 1
                lower = 8;
            else 
                lower = par_str4(i_subs).Orient_T(2,count)-1;
            end
            if par_str4(i_subs).Orient_T(2,count) == 8
                upper = 1;
            else
                upper = par_str4(i_subs).Orient_T(2,count)+1;
            end
            par_str4(i_subs).Orient_T(5,count) = out_rotation{i}(par_str4(i_subs).Orient_T(2,count)); % incorrect gabor
            par_str4(i_subs).Orient_T(3,count) = out_rotation{i}(lower); % counterclockwise 1 position of incorrect gabor
            normDeg = mod(par_str4(i_subs).Orient_T(3,count) - par_str4(i_subs).Orient_T(5,count),360);
            par_str4(i_subs).Orient_T(4,count) = min(360-normDeg, normDeg);
            par_str4(i_subs).Orient_T(7,count) = out_rotation{i}(upper); % clockwise 1 position of inccorect gabor
            normDeg = mod(par_str4(i_subs).Orient_T(7,count) - par_str4(i_subs).Orient_T(5,count),360);
            par_str4(i_subs).Orient_T(6,count) = min(360-normDeg, normDeg);
            par_str4(i_subs).Orient_T(8,count) = out_RT(i);
            par_str4(i_subs).Orient_T(9,count) = out_soa(i);

        end
    end
    par_str4(i_subs).Orient_Count = count;
    
    par_str4(i_subs).Orient_T_L_Sum = sum(par_str4(i_subs).Orient_T(4,:));
    par_str4(i_subs).Orient_T_L_Weighted = par_str4(i_subs).Orient_T_L_Sum/count;
    par_str4(i_subs).Orient_T_L_std = std(par_str4(i_subs).Orient_T(4,:));

    par_str4(i_subs).Orient_T_R_Sum = sum(par_str4(i_subs).Orient_T(6,:));
    par_str4(i_subs).Orient_T_R_Weighted = par_str4(i_subs).Orient_T_R_Sum/count;
    par_str4(i_subs).Orient_T_R_std = std(par_str4(i_subs).Orient_T(6,:));
    
    % switch - 
    
    subplot(widthHeight,widthHeight,i_subs); 
        hold on
        for i_point=1:count 
          plot(par_str4(i_subs).Orient_T(4,i_point), par_str4(i_subs).Orient_T(8,i_point),'sk','markersize',8,'markerfacecolor',ColorMap3(par_str4(i_subs).Orient_T(9,i_point)));
          plot(par_str4(i_subs).Orient_T(6,i_point), par_str4(i_subs).Orient_T(8,i_point),'sk','markersize',8,'markerfacecolor',ColorMap3(par_str4(i_subs).Orient_T(9,i_point)));
        end
        for ii = 1:size(cmap1,1)
            p(ii) = patch(NaN, NaN, cmap3(ii,:));
        end
        legend(p, lbl,'Location', 'northeastoutside');
        xlim([0 180]); 
        ylim([.3 1.5])
        set(gca,'XTick',0:20:180)
        xlabel('Incorrect Gabor Orientation Difference (°)')
        ylabel('Reaction Time')
        title(current_sub)
end

suptitle('Correct Gabor Orientation Diff to Adjacent vs. RT - Shade Indicates SOA')

Ori_T_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_T_Diff_Mean(i) = par_str4(i).Orient_T_L_Weighted - par_str4(i).Orient_T_R_Weighted;
end
Ori_T_Diff_GA = mean(Ori_T_Diff_Mean);
Ori_T_Diff_SE = std(Ori_T_Diff_Mean);

%% Looking at the incorrect trial gabor orientation as a function of correct gabor orientation
figure('Position',[25,25,1900,1100]); 
widthHeight = ceil(sqrt(nsubs));
colour = 1;

if colour == 0
    cmap1 = cmap2;
    ColorMap1 = ColorMap2;
end

for i_subs = 1:nsubs
    count = 0;
    current_sub = sub_nums{i_subs};
    
    par_str5(i_subs).Orient_Cor = zeros(8,lengthy);

    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);

    for i = 1:lengthy
        if isnan(out_incorrect_gabor(i)) ~= true 
            count = count + 1;
            par_str5(i_subs).Orient_Cor(1,count) = i; par_str5(i_subs).Orient_Cor(2,count) = out_incorrect_gabor(i);
            par_str5(i_subs).Orient_Cor(3,count) = out_rotation{i}(trialList(i,1)); % correct gabor
            par_str5(i_subs).Orient_Cor(4,count) = out_rotation{i}(par_str5(i_subs).Orient_Cor(2,count)); % incorrect gabor
            normDeg = mod(par_str5(i_subs).Orient_Cor(3,count) - par_str5(i_subs).Orient_Cor(4,count),360);
            par_str5(i_subs).Orient_Cor(5,count) = min(360-normDeg, normDeg);
            par_str5(i_subs).Orient_Cor(6,count) = out_RT(i);
            par_str5(i_subs).Orient_Cor(7,count) = out_soa(i);

%             par_str5(i_subs).Orient_Cor(7,count) = [[ColorMap(out_soa(i))]];
        end
    end
    par_str5(i_subs).Orient_Count = count;
    % Look at correlating individual reaction times under 2 seconds with
    % overall difference sums for each SOA (different colours
    par_str5(i_subs).Orient_Cor_Sum = sum(par_str5(i_subs).Orient_Cor(5,:));
    par_str5(i_subs).Orient_Cor_Weighted = par_str5(i_subs).Orient_Cor_Sum/count;
    par_str5(i_subs).Orient_Cor_Diff = sum(par_str5(i_subs).Orient_Cor(5,:));
    par_str5(i_subs).Orient_Cor_std = std(par_str5(i_subs).Orient_Cor(5,:));

    subplot(widthHeight,widthHeight,i_subs); 
        for i_point=1:count
          hold on
          plot(par_str5(i_subs).Orient_Cor(5,i_point), par_str5(i_subs).Orient_Cor(6,i_point),'sk','markersize',8,'markerfacecolor',ColorMap3(par_str5(i_subs).Orient_Cor(7,i_point)));
        end
        for ii = 1:size(cmap1,1)
            p(ii) = patch(NaN, NaN, cmap3(ii,:));
        end
        legend(p, lbl,'Location', 'northeastoutside');
        xlim([0 180]); 
        ylim([.3 1.5])
        set(gca,'XTick',0:20:180)
        xlabel('Incorrect Gabor Orientation Difference (°)')
        ylabel('Reaction Time')
        title(current_sub)
end
suptitle('Incorrect Gabor Orientation Diff to Correct vs. RT - Shade Indicates SOA')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ori_Cor_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_Cor_Diff_Mean(i) = par_str5(i).Orient_Cor_Weighted;
end
Ori_Cor_Diff_GA = mean(Ori_Cor_Diff_Mean);
Ori_Cor_Diff_SE = std(Ori_Cor_Diff_Mean);
