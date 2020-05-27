%% Trabalho 1 - ICSTS
%  Written by Jorge Melo and Xavier Pinho

close all

%% Show info

option=input('\nChoose type of message to validate and see. \n 1. Admission  \n 2. Observation \n ');
current_folder = pwd;
functions = strcat(pwd, '\functions');
addpath functions
% Show admission message
if option==1
    filename = 'ADT_A01.txt';
    admission_structured_data = admission(filename);
    if ~isempty(admission_structured_data)
        show_admission(admission_structured_data);
    end
end

% Show observations message
if option==2
    filename = 'ORU_R01.txt';
    observations_structured_data = observation(filename);
    if ~isempty(observations_structured_data)
        ecg_data=[];
        for i=1:size(observations_structured_data{4}{2}{3}{1}{3},2)
            ecg_data=[ecg_data,str2num(cell2mat((observations_structured_data{4}{2}{3}{1}{3}(i))))];
        end
        show_observations(observations_structured_data, ecg_data);
    end
end

%% Admission
function admission_structured_data = admission(filename)
    admission_data=load_and_split(filename);
    [result_admission,response_admission]=val_admission(admission_data);

    disp(response_admission)
    if result_admission==true
        admission_structured_data=struct_admission(admission_data);
    end
end

%% Observation

function observations_structured_data = observation(filename)
    observations_data=load_and_split(filename);
    [result_observations,response_observations]=val_observations(observations_data);
    disp(response_observations)
    if result_observations==true
        observations_structured_data=struct_observations(observations_data);
    end
end
