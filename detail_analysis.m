

ccc
sub_nums = {'000', '001', '002', '003', '004', '005', '006', '007',...
			'008', '009', '010', '011', '012'};
			
nsubs = length(sub_nums);

%% Accuracy
figure('Position',[25,25,1000,1000]); 
widthHeight = ceil(sqrt(nsubs));
for i_sub = 1:nsubs 
	current_sub = sub_nums{i_sub};

	%Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	% Save data
	load(['.\Data\' Filename.name]);

	if i_sub == 1 % make output variables here once loaded first file
		turn_group = zeros(nsubs,length(soas));
		control_group = zeros(nsubs,length(soas));
	end

	% Plot results
	subplot(widthHeight,widthHeight,i_sub); 
		plot(soas,turn_out,'r',soas,control_out,'b'); 
			legend({'Flexion','Control'});
			xlim([min(soas) max(soas)]); 
			set(gca,'XTick',min(soas):1:max(soas))
			xlabel('Gabor First < -- SOA (frames) -- > Gabor After')
			ylabel('Detection Proportion')
			ylim([.01 1.05])
			title(current_sub)

	turn_group(i_sub,:) = turn_out;
	control_group(i_sub,:) = control_out;
    
    isoa = 0;
    for this_soa = soas
        isoa = isoa + 1;
        temp_turn = out_RT(out_soa == this_soa & responded & turn_trials);
        turn_outRT(isoa) = mean(temp_turn);
        temp_cont = out_RT(out_soa == this_soa & responded & control_trials);
        control_out(isoa) = mean(temp_cont);
        clear temp_turn temp_cont
    end

end

% Plot Grand Average results
figure;
	boundedline(soas, mean(turn_group,1), std(turn_group,[],1) / sqrt(nsubs),'r', ...
		soas, mean(control_group,1), std(control_group,[],1) / sqrt(nsubs),'b');
	legend({'Flexion','Control'});
	xlim([min(soas) max(soas)]); 
	set(gca,'XTick',min(soas):1:max(soas))
	xlabel('Gabor Change First < ------ SOA (frames) ------ > Gabor Change After')
	ylabel('Detection Proportion')
	ylim([.01 1.05])
	title('Grand Average')

%% RT
figure('Position',[25,25,1000,1000]); 
widthHeight = ceil(sqrt(nsubs));
for i_sub = 1:nsubs 
	current_sub = sub_nums{i_sub};

	%Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	% Save data
	load(['.\Data\' Filename.name]);

    if i_sub == 1 % make output variables here once loaded first file
		turn_groupRT = zeros(nsubs,length(soas));
		control_groupRT = zeros(nsubs,length(soas));
    end
    
    isoa = 0;
    for this_soa = soas
        isoa = isoa + 1;
        temp_turn = out_RT(out_soa == this_soa & responded & turn_trials);
        turn_outRT(isoa) = mean(temp_turn);
        temp_cont = out_RT(out_soa == this_soa & responded & control_trials);
        control_outRT(isoa) = mean(temp_cont);
        clear temp_turn temp_cont
    end
    
    % Plot results
	subplot(widthHeight,widthHeight,i_sub); 
		plot(soas,turn_outRT,'r',soas,control_outRT,'b'); 
			legend({'Flexion','Control'});
			xlim([min(soas) max(soas)]); 
			set(gca,'XTick',min(soas):1:max(soas))
			xlabel('Gabor First < -- SOA (frames) -- > Gabor After')
			ylabel('Reaction Time')
			ylim([.4 1.8])
			title(current_sub)
            
    turn_groupRT(i_sub,:) = turn_outRT;
	control_groupRT(i_sub,:) = control_outRT;

end

% Plot Grand Average results
figure;
	boundedline(soas, mean(turn_groupRT,1), std(turn_groupRT,[],1) / sqrt(nsubs),'r', ...
		soas, mean(control_groupRT,1), std(control_groupRT,[],1) / sqrt(nsubs),'b');
	legend({'Flexion','Control'});
	xlim([min(soas) max(soas)]); 
	set(gca,'XTick',min(soas):1:max(soas))
	xlabel('Gabor Change First < ------ SOA (frames) ------ > Gabor Change After')
	ylabel('Reaction Time')
% 	ylim([.01 1.05])
	title('Grand Average')


