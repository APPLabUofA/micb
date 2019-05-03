
ccc
sub_nums = {'000', '001', '002', '003', '004', '005', '006', '007',...
			'008', '009', '010', '011', '012'};
			
nsubs = length(sub_nums);

figure('Position',[25,25,1000,1000]); 
widthHeight = ceil(sqrt(nsubs));



for i_sub = 1:nsubs 
	current_sub = sub_nums{i_sub};

	%Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	%% Save data
	load(['.\Data\' Filename.name]);

	if i_sub == 1 % make output variables here once loaded first file
		turn_group = zeros(nsubs,length(soas));
		control_group = zeros(nsubs,length(soas));
	end

	%% Plot results
% 	subplot(widthHeight,widthHeight,i_sub); 
% 		plot(soas,turn_out,'r',soas,control_out,'b'); 
% 			legend({'Flexion','Control'});
% 			xlim([min(soas) max(soas)]); 
% 			set(gca,'XTick',min(soas):1:max(soas))
% 			xlabel('Gabor First < -- SOA (frames) -- > Gabor After')
% 			ylabel('Detection Proportion')
% 			ylim([.01 1.05])
% 			title(current_sub)

	turn_group(i_sub,:) = turn_out;
	control_group(i_sub,:) = control_out;

end


%% Plot Grand Average results
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
    
    
    
    
    