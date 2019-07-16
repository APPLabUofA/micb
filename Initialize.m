function Initialize()

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
end