% Motion-Induced Change Blindness, 
% Developed by Richard Yao
% Modified by Katherine Wood 
% Modified by Kyle Mathewson 

%to test asynchrony between change and motion change


clear all
Screen('Preference', 'SkipSyncTests', 1)
clc;
seed = ceil(sum(clock)*1000);
rand('twister',seed);

global w bgcolor rect gaborPatch arrayRects rotation centerOfArray ...
    direction movementIncrement fixationSize fixationColor fixationRect

% /////////////////////////////////////////////////////////////////////////
%% Input
Info.number = input('Participant Number:','s');
Info.date = datestr(now,30); % 'dd-mmm-yyyy HH:MM:SS' 
% output file will be named after the inputs
Filename = [Info.number '--' Info.date '_data.mat'];

% /////////////////////////////////////////////////////////////////////////
%% Basic parameters
bgcolor = [128 128 128];
[w rect] = Screen('OpenWindow',0,bgcolor);
xc = rect(3)./2;
yc = rect(4)./2;
xBorder = round(rect(3)./6);
yBorder = round(rect(4)./6);
textSize = round(rect(4)*.02);
Screen('TextSize',w,textSize);
directionNames = {'Right' 'Left'};

% fixation parameters
fixationPause = .5;
fixationColor = [0 0 0];
fixationSize = 2;

% gabor array parameters
numberOfGabors = 8;
arrayCenters = zeros(numberOfGabors,2);
r = round(rect(4)./10);
g = round(.8*r);
gaborSize = g;

% stimulus motion parameters
movementSpeed = 3;
rotationSize = 30;

% trial parameters
practiceTrials = 2;
breakEvery = 50;
timeLimit = 5;
feedbackPause = .5;

%pick soas
soas = sort([-8:2:8,-1,1]); %changed SOAs 
nsoas = length(soas);

% /////////////////////////////////////////////////////////////////////////
%% Read in image
Screen('BlendFunction',w,GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
[gaborMatrix map alpha] = imread('single_gabor_75px.png');
gaborMatrix(:,:,4) = alpha(:,:);
gaborPatch = Screen('MakeTexture',w,gaborMatrix);

% /////////////////////////////////////////////////////////////////////////
%% Counterbalancing
% reps = 5; % Number of reps per angle condition per direction
reps = 4; % Number of reps per angle condition per direction
trialList = [repmat(1:numberOfGabors,1,3*reps);...  %list of which target
    zeros(1,numberOfGabors*reps) ...  %list of which angle
    repmat(90,1,numberOfGabors*reps)...
    repmat(270,1,numberOfGabors*reps)];
%list of which direction
trialList = [trialList trialList; ...
        zeros(1,numberOfGabors*3*reps) ones(1,numberOfGabors*3*reps)]; 
trialList = trialList(:,randperm(length(trialList)));
practiceList = trialList(:,randperm(length(trialList)));
trialList = trialList';
practiceList = practiceList';
totalTrials = length(trialList);

% /////////////////////////////////////////////////////////////////////////
%% Array Center Points
for i = 1:numberOfGabors
    arrayCenters(i,1) = r*cos((i-1)*(2*pi/numberOfGabors));
    arrayCenters(i,2) = r*sin((i-1)*(2*pi/numberOfGabors));
end
arrayCenters = round(arrayCenters);
centeredRects = [arrayCenters arrayCenters] + ...
        round(repmat([xc-g/2 yc-g/2 xc+g/2 yc+g/2],numberOfGabors,1));
centeredRects = centeredRects';

%outputs
out_soa = [];
out_direction = []; 
out_angle = [];  
out_accuracy = [];
out_RT = [];

% /////////////////////////////////////////////////////////////////////////
%% Instructions %%
Screen('FillRect',w,bgcolor);
DrawFormattedText(w,'In the following task, you will follow, with your eyes, an array of striped patches moving across the screen.\n\nOn EVERY TRIAL, one of the patches will rotate slightly while moving with its neighbors. When prompted, you will have to click on the patch that rotated.\n\nWe are testing what conditions make that rotation harder or easier to see, so do not be surprised if you did not see any rotation. Just do your best and take a guess if you are unsure.\n\nThe task is easiest if you follow the dot that appears at the middle of the array, so follow that with your eyes on each trial.\n\n\nLet the experimenter know if you have any questions.\n\nClick the mouse to continue.','center','center',[]);
Screen('Flip',w)
GetClicks(w);
WaitSecs(1.25);

% /////////////////////////////////////////////////////////////////////////
%% ---- Experiment ----
% /////////////////////////////////////////////////////////////////////////
for k = -(practiceTrials+1):length(trialList)
    fprintf(num2str(k))
    fprintf('\n')
    %pick SOA
    this_soa = soas(randi(nsoas));

    %Trial type
    if k < 0
        direction = practiceList(-k,3);
        target = practiceList(-k,1);
        angle = practiceList(-k,2);
        trialNum = 'Practice';
    elseif k == 0
        direction = practiceList(practiceTrials,3);
        target = practiceList(practiceTrials,1);
        angle = practiceList(practiceTrials,2);
        trialNum = 'Practice';
    else
        direction = trialList(k,3);
        target = trialList(k,1);
        angle = trialList(k,2);
        trialNum = num2str(k);
    end

    %Stimuli bounds
    arrayRects = [arrayCenters arrayCenters] + ...
                round(repmat([g/2+r-g/2 yc-g/2 g/2+r+g/2 yc+g/2],numberOfGabors,1));
    if direction
        arrayRects = arrayRects + repmat([-(2*r+g)+rect(3)-xBorder 0],numberOfGabors,2);
    else
        arrayRects = arrayRects + repmat([xBorder 0],numberOfGabors,2);
    end
    arrayRects = arrayRects';

% /////////////////////////////////////////////////////////////////////////
    %% Gabors
    rotation = round(rand(1, numberOfGabors) * 360);
    gaborPatch = Screen('MakeTexture',w,gaborMatrix);

    %%%%%%%%
    %%%%%%%%
    %%%%%%%%

% /////////////////////////////////////////////////////////////////////////    
    %% STIMULUS CODE %%
    HideCursor
    
    motion_changePoint = xc;
    motion_flexion_height = yc;

    %%%
    gabor_soa_frames = this_soa; % negative before motion 
    %%%

    gabor_soa_frames = -gabor_soa_frames; %switch sign
    gabor_changePoint = gabor_soa_frames * 3; % moves three pixels on each frame
    
    trialOver = 0;
    motionOver = 0; % motion change
    gaborOver = 0; % gabor change
    movementIncrement = repmat([movementSpeed 0 movementSpeed 0],numberOfGabors,1)';
    DrawStim()
    WaitSecs(fixationPause); 

    while ~trialOver

        % check if reached the edge and set flag
        if max(arrayRects(3, :)) > rect(3)-xBorder || ...
                max(arrayRects(4, :)) > rect(4)-yBorder || ...
                min(arrayRects(3, :)) < xBorder || ...
                min(arrayRects(4, :)) < yBorder;
            trialOver = 1;
        end

        % check for first motion change point, change, and flag
        motion_howfar = ((-1) ^ (direction+1)) * (centerOfArray(1) - motion_changePoint) + ...
                        (-1) * abs(centerOfArray(2) - motion_flexion_height);
        if motion_howfar < 1 & ~motionOver
            motionOver = 1;
            % Change movement direction
            movementIncrement = repmat(movementSpeed.*[cosd(angle) ...
                                    sind(angle) cosd(angle) sind(angle)], ...
                                    numberOfGabors, 1)';
        end

        % check for gabor change point, change, and flag
        gabor_howfar = ((-1) ^ (direction+1)) * (centerOfArray(1) - motion_changePoint) + ...
                       (-1) * abs(centerOfArray(2) - motion_flexion_height);
        if gabor_howfar < gabor_changePoint & ~gaborOver
            gaborOver = 1;
            %Change Gabor angle
            rotation(target) = rotation(target) + rotationSize;
        end

        MoveStim()
        DrawStim()
    end


    %%%%%%%%
    %%%%%%%%
    %%%%%%%%

% /////////////////////////////////////////////////////////////////////////    
    %% Probe %%
    Screen('FillRect',w,bgcolor,rect);
    Screen('Flip',w);
    WaitSecs(.1);
    
    ShowCursor('Arrow');
    SetMouse(xc,yc)
    
    Screen('FillRect',w,bgcolor,rect);
    DrawFormattedText(w,'Click the patch that rotated:','center',yc-r-g);
    Screen('DrawTextures',w,gaborPatch,[],centeredRects,rotation);
    Screen('FillOval',w,fixationColor,[xc-fixationSize yc-fixationSize xc+fixationSize yc+fixationSize]);
    Screen('Flip',w);
    
    accuracy = 2;
    startTime = GetSecs;
    clicked = 0;
    while GetSecs-startTime<timeLimit && ~clicked
        [x y buttons] = GetMouse;
        if any(buttons)
            clicked = 1;
            timesUp = 1;
        end
    end
    %%% Create a 4X8 double 
    non_targets = centredRects(1:8);
    %%% Reduce to a 4X7 by removing the target
    non_targets(:,target) = [];
    incorrectRect = centeredRects(:,non_targets);
    incorrectRect = incorrectRect;
    correctRect = centeredRects(:,target);
    correctRect = correctRect';
    
    %%% KeySet for all dictionaries
    incorrect_keySet = {'1','2','3','4','5','6','7'};
    %%% X axis value keys
    incorrect_valueSet_left = {non_targets(1,:)}; incorrect_valueSet_right = {non_targets(3,:)};
    %%% Y axis value keys
    incorrect_valueSet_bottom = {non_targets(2,:)}; incorrect_valueSet_top = {non_targets(4,:)};
    %%% X axis map
    incorrect_Map_left = containers.Map(incorrect_keySet,valueSet_time_1); incorrect_Map_right = containers.Map(incorrect_keySet,valueSet_time_2);
    %%% Y axis map
    incorrect_Map_top = containers.Map(incorrect_keySet,valueSet_time_2); incorrect_Map_bottom = containers.Map(incorrect_keySet,valueSet_time_2);
    
    if clicked==1&&x>=correctRect(1)&&x<=correctRect(3)&&y>=correctRect(2)&&y<=correctRect(4)
        accuracy = 1;
        RT = GetSecs-startTime;
        Screen('FillRect',w,bgcolor,rect);
        DrawFormattedText(w,'Correct','center','center');
        Screen('Flip',w);
    elseif clicked==1
        for i = length(incorrect_keySet)
            if x>=incorrect_Map_left(i)&&x<=incorrect_Map_right(i)&&y>=incorrect_Map_top(i)&&y<=incorrect_Map_bottom(i)
                incorrect_gabor = i
                accuracy = 0;
                gabor_press = 1;
                Screen('FillRect',w,bgcolor,rect);
                DrawFormattedText(w,'Please Click on a Gabor','center','center');
                RT = GetSecs-startTime;
                Screen('Flip',w);
            end
        end
    elseif clicked==1 %%x>&&
        accuracy = 0;
        gabor_press = 0;
        Screen('FillRect',w,bgcolor,rect);
        DrawFormattedText(w,'Please Click on a Gabor','center','center');
        RT = GetSecs-startTime;
        Screen('Flip',w);
    elseif clicked == 0
        Screen('FillRect',w,bgcolor,rect);
        DrawFormattedText(w,'Please respond more quickly','center','center');
        Screen('Flip',w);
        accuracy = 2;
        RT = timeLimit;
    end
    
    WaitSecs(feedbackPause);
    Screen('FillRect',w,bgcolor,rect);
    Screen('flip',w);

    if k>0
        out_soa = [out_soa this_soa];
        out_direction = [out_direction direction]; 
        out_angle = [out_angle angle];  %270 left, 90 Right, 0 straight
        out_accuracy = [out_accuracy accuracy];
        out_RT = [out_RT RT];
    end


    Screen('Close');  
end
% /////////////////////////////////////////////////////////////////////////
fclose('all');
Screen('CloseAll');


turn_trials = out_angle ~= 0;
control_trials = out_angle == 0;
responded = out_accuracy ~= 2;

isoa = 0;
for this_soa = soas
    isoa = isoa + 1;
    temp_turn = out_accuracy(out_soa == this_soa & responded & turn_trials);
    turn_out(isoa) = sum(temp_turn)/length(temp_turn);
    temp_cont = out_accuracy(out_soa == this_soa & responded & control_trials);
    control_out(isoa) = sum(temp_cont)/length(temp_cont);
end

% /////////////////////////////////////////////////////////////////////////
%% Save data
save(Filename)
% /////////////////////////////////////////////////////////////////////////
%% Plot results
figure; 
plot(soas,turn_out,'r',soas,control_out,'b'); 
legend({'Flexion','Control'});
xlabel('Gabor Change First < ------ SOA (frames) ------ > Gabor Change After')
ylabel('Detection Proportion')
ylim([.01 1.05])
% /////////////////////////////////////////////////////////////////////////

function MoveStim()
    global arrayRects direction movementIncrement
    arrayRects = arrayRects + ((-1)^direction)*movementIncrement;
end

function DrawStim() 
    global w bgcolor rect gaborPatch arrayRects rotation centerOfArray fixationSize fixationColor fixationRect
    Screen('FillRect',w,bgcolor,rect);  
    Screen('DrawTextures',w,gaborPatch,[],arrayRects,rotation); 
    centerOfArray = [(min(arrayRects(1,:))+max(arrayRects(3,:)))/2 (min(arrayRects(2,:))+max(arrayRects(4,:)))/2];
    fixationRect = round([centerOfArray(1)-fixationSize centerOfArray(2)-fixationSize centerOfArray(1)+fixationSize centerOfArray(2)+fixationSize]);
    Screen('FillOval',w,fixationColor,fixationRect);  
    Screen('Flip',w);
end








