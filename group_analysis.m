
sub_nums = {'001', '002'}
nsubs = length(sub_nums)

for i_sub = 1:nsubs 
	%Find output filename

	Filename = dir(['.\Data\' sub_nums(i_sub) '*')

	%% Save data
	load(['.\Data\' Filename])

	% /////////////////////////////////////////////////////////////////////////
	%% Plot results
	figure; 
	plot(soas,turn_out,'r',soas,control_out,'b'); 
	legend({'Flexion','Control'});
	xlim([min(soas) max(soas)]); xticks(min(soas):1:max(soas))
	xlabel('Gabor Change First < ------ SOA (frames) ------ > Gabor Change After')
	ylabel('Detection Proportion')
	ylim([.01 1.05])
end
