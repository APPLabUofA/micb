function Load(struct_num)

    count = 0; count_x = 0;
    current_sub = sub_nums{i_subs};
    
    par_str{structs_num}(i_subs).Incor = zeros(6,lengthy);


    %Find output filename
	Filename = dir(['.\Data\' current_sub '*']);

	load(['.\Data\' Filename.name]);
end
