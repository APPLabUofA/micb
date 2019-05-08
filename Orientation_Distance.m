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


%% Looking at the incorrect gabor distances as a function of direction

figure('Position',[25,25,1000,1000]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count1 = 0; count2 = 0;
    current_sub = sub_nums{i_subs};
    
    par_str1(i_subs).Incor_L = zeros(5,lengthy);
    par_str1(i_subs).Incor_R = zeros(5,lengthy);

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
            elseif out_direction(i) == 1
                count2 = count2 + 1;
                par_str1(i_subs).Incor_R(1,count2) = i; par_str1(i_subs).Incor_R(2,count2) = out_incorrect_gabor(i);
                par_str1(i_subs).Incor_R(3,count2) = trialList(i,1);
                normDeg = mod(par_str1(i_subs).Incor_R(2,count2) - par_str1(i_subs).Incor_R(3,count2),8);
                par_str1(i_subs).Incor_R(4,count2) = min(8-normDeg, normDeg);
                par_str1(i_subs).Incor_R(5,count2) = out_RT(i);
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
        scatter(par_str1(i_subs).Incor_L(4,:),par_str1(i_subs).Incor_L(5,:),'b')
        hold on
        scatter(par_str1(i_subs).Incor_R(4,:),par_str1(i_subs).Incor_R(5,:),'r')
        hold off
			legend({'Left','Right'});
			xlim([0 max(Gabor_List/2+1)]); 
			set(gca,'XTick',min(Gabor_List):1:max(Gabor_List))
			xlabel('Incorrect Gabor Distance')
			ylabel('Reaction Time (ms)')
 			ylim([.01 5])
			title(current_sub)

end

Dir_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Dir_Diff_Mean(i) = par_str1(i).Incor_L_Weighted - par_str1(i).Incor_R_Weighted;
end
Dir_Diff_GA = mean(Dir_Diff_Mean);
Dir_Diff_SE = std(Dir_Diff_Mean);

% par_str1 - output structured as follows
% Incor_Left & Incor_Right
%1|index
%2|incorrect gabor position
%3|correct gabor position
%4|difference in position between gabors
%5|Reaction Time

% Plots
% Reaction time versus difference in position between correct and incorrect
% in Control trials
% fig = figure;
% scatter(Incor_L(4,:),Incor_L(5,:))
% title('RT and Difference of Incorrect and Correct Gabor Position - Left Trials');
% xlabel('Position Difference (degrees)');
% ylabel('Reaction Time (ms)');

%% Looking at the incorrect trial gabor distances as a function of condition

figure('Position',[25,25,1000,1000]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count1 = 0; count2 = 0;
    current_sub = sub_nums{i_subs};
    
    par_str2(i_subs).Incor_Con = zeros(5,lengthy);
    par_str2(i_subs).Incor_Exp = zeros(5,lengthy);

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
            else
                count2 = count2 + 1;
                par_str2(i_subs).Incor_Exp(1,count2) = i; par_str2(i_subs).Incor_Exp(2,count2) = out_incorrect_gabor(i);
                par_str2(i_subs).Incor_Exp(3,count2) = trialList(i,1);
                normDeg = mod(par_str2(i_subs).Incor_Exp(2,count2) - par_str2(i_subs).Incor_Exp(3,count2),8);
                par_str2(i_subs).Incor_Exp(4,count2) = min(8-normDeg, normDeg);
                par_str2(i_subs).Incor_Exp(5,count2) = out_RT(i);
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
        scatter(par_str2(i_subs).Incor_Con(4,:),par_str2(i_subs).Incor_Con(5,:),'b')
        hold on
        scatter(par_str2(i_subs).Incor_Exp(4,:),par_str2(i_subs).Incor_Exp(5,:),'r')
        hold off
			legend({'Control','Exprimental'});
			xlim([0 max(Gabor_List/2+1)]); 
			set(gca,'XTick',min(Gabor_List):1:max(Gabor_List))
			xlabel('Incorrect Gabor Distance')
			ylabel('Reaction Time')
 			ylim([.01 5])
			title(current_sub)
end


% Now we are going to representing the means of gabor difference across
% Control and Experimental
Cond_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Cond_Diff_Mean(i) = par_str2(i).Incor_Con_Weighted - par_str2(i).Incor_Exp_Weighted;
end
Cond_Diff_GA = mean(Cond_Diff_Mean);
Cond_Diff_SE = std(Cond_Diff_Mean);

% output structured as follows
% Incor_Con & Incor_Exp
%1|index
%2|incorrect gabor position
%3|correct gabor position
%4|difference in position between gabors
%5|Reaction Time

% Plots
% Reaction time versus difference in position between correct and incorrect
% in Control trials
% fig = figure;
% scatter(Incor_Con(4,:),Incor_Con(5,:))
% title('RT and Difference of Incorrect and Correct Gabor Position - Control Trials');
% xlabel('Position Difference (degrees)');
% ylabel('Reaction Time (ms)');

%% Looking at the incorrect trial gabor orientation as a function of surrounding gabor orientation

figure('Position',[25,25,1000,1000]); 
widthHeight = ceil(sqrt(nsubs));

for i_subs = 1:nsubs
    count = 0;
    current_sub = sub_nums{i_subs};
    
    par_str3(i_subs).Orient_F = zeros(8,lengthy);

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
        scatter(par_str3(i_subs).Orient_F(4,:),par_str3(i_subs).Orient_F(8,:),'b')
        hold on
        scatter(par_str3(i_subs).Orient_F(6,:),par_str3(i_subs).Orient_F(8,:),'r')
        hold off
			legend({'Counterclockwise','Clockwise'});
			xlim([0 180]); 
			set(gca,'XTick',0:20:180)
			xlabel('Incorrect Gabor Orientation Difference')
			ylabel('Reaction Time')
			title(current_sub)
end

Ori_F_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_F_Diff_Mean(i) = par_str3(i).Orient_F_L_Weighted - par_str3(i).Orient_F_R_Weighted;
end
Ori_F_Diff_GA = mean(Ori_F_Diff_Mean);
Ori_F_Diff_SE = std(Ori_F_Diff_Mean);

% Plots
% Reaction time versus difference in degree of left gabor orientation
% fig = figure;
% scatter(Orient_F(4,:),Orient_F(8,:))
% title('RT and Difference of Incorrect and Clockwise Flanking Gabor');
% xlabel('Angle Difference (degrees)');
% ylabel('Reaction Time (ms)');

% output structured as follows
% 1|index of trial
% 2|incorrect gabor position
% 3|counterclockwise gabor orientation
% 4|difference between counterclockwise and incorrect gabor
% 5|incorrect orientation
% 6|difference between clockwise and incorrect gabor
% 7|clockwise gabor orientation
% 8|Reaction Time

%% Looking at correct trial gabor orientation as a function of surrounding gabor orientation

figure('Position',[25,25,1000,1000]); 
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
        scatter(par_str4(i_subs).Orient_T(4,:),par_str4(i_subs).Orient_T(8,:),'b')
        hold on
        scatter(par_str4(i_subs).Orient_T(6,:),par_str4(i_subs).Orient_T(8,:),'r')
        hold off
			legend({'Counterclockwise','Clockwise'});
			xlim([0 180]); 
			set(gca,'XTick',0:20:180)
			xlabel('Incorrect Gabor Orientation Difference')
			ylabel('Reaction Time')
			title(current_sub) 
end

Ori_T_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_T_Diff_Mean(i) = par_str2(i).Orient_T_L_Weighted - par_str2(i).Orient_T_R_Weighted;
end
Ori_T_Diff_GA = mean(Ori_T_Diff_Mean);
Ori_T_Diff_SE = std(Ori_T_Diff_Mean);
% output structured as follows
% 1|index of trial
% 2|incorrect gabor position
% 3|counterclockwise gabor orientation
% 4|difference between counterclockwise and incorrect gabor
% 5|incorrect orientation
% 6|difference between clockwise and incorrect gabor
% 7|clockwise gabor orientation
% 8|Reaction Time

% Plots
% Reaction time versus difference in degree of left gabor orientation
% fig = figure;
% scatter(Orient_T(4,:),Orient_T(8,:))
% title('RT and Difference of Correct and Clockwise Flanking Gabor');
% xlabel('Angle Difference (degrees)');
% ylabel('Reaction Time (ms)');

%% Looking at the incorrect trial gabor orientation as a function of correct gabor orientation
figure('Position',[25,25,1000,1000]); 
widthHeight = ceil(sqrt(nsubs));

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
%         c = gradient(y);
%         c = par_str5(i_subs).Orient_Cor(7,count);
%         scatter(par_str5(i_subs).Orient_Cor(5,:),par_str5(i_subs).Orient_Cor(6,:),par_str5(i_subs).Orient_Cor(7,count))
%         scatter(par_str5(i_subs).Orient_Cor(5,:),par_str5(i_subs).Orient_Cor(6,:),'b')
            for i=1:length(par_str5(i_subs).Orient_Cor(6,:))
                %Select color
                if par_str5(i_subs).Orient_Cor(6,i) < 0
                    mycolor = 'r';
                else
                    mycolor = 'g';
                end
                plot(par_str5(i_subs).Orient_Cor(5,i), par_str5(i_subs).Orient_Cor(6,i), 'sk','markersize',8,'markerfacecolor',mycolor);
            end
            legend({'Counterclockwise','Clockwise'});
			xlim([0 180]); 
			set(gca,'XTick',0:20:180)
			xlabel('Incorrect Gabor Orientation Difference')
			ylabel('Reaction Time')
			title(current_sub)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = 0:0.03:3;
y = sin(2*pi.*t);

figure; hold on;
plot(t,y,'k');
grid;

for i=1:length(y)

    %Select color
    if y(i)<0
        mycolor = 'r';
    else
        mycolor = 'g';
    end

    plot(t(i), y(i), 'sk','markersize',8,'markerfacecolor',mycolor);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ori_Cor_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_Cor_Diff_Mean(i) = par_str5(i).Orient_Cor_Weighted;
end
Ori_Cor_Diff_GA = mean(Ori_Cor_Diff_Mean);
Ori_Cor_Diff_SE = std(Ori_Cor_Diff_Mean);

% Look at reaction time as a function of correct gabor orientation

% output structured as follows
% 1|index of trial
% 2|incorrect gabor position
% 3|correct orientation
% 4|incorrect orientation
% 5|difference between correct and incorrect

% % Plots
% fig = figure;
% scatter(Orient_Cor(5,:),Orient_Cor(6,:))
% title('RT and Difference of Correct and Incorrect Gabor Orientation');
% xlabel('Angle Difference (degrees)');
% ylabel('Reaction Time (ms)');

Cond_Diff_Mean = zeros(1,nsubs);

for i = 1:nsubs
    Ori_Diff_Mean(i) = par_str2(i).Incor_Con_Weighted - par_str2(i).Incor_Exp_Weighted;
end

Ori_Diff_SE = std(Cond_Diff_Mean);

%%
[x,y,z] = peaks;
z = max(peaks* 100000, 0);
cmap = [1 1 1; 1 0 0; 1 .5 0; 1 1 0; 0 1 0];
lbl =  {'0', '1-6400','6400-80000', '80001-500000', '500000+'};
[n,bin] = histc(z, [0 1 6400 80000 500000 Inf]); 
pcolor(x,y,bin);
colormap(cmap);


for ii = 1:size(cmap,1)
    p(ii) = patch(NaN, NaN, cmap(ii,:));
end
legend(p, lbl);


cb = colorbar;
set(cb, 'ticks', 1:5, 'ticklabels', lbl);
set(gca, 'clim', [0.5 5.5]);

