close all;
clear all

dir_name = 'Basement';


% [ GT_gate ] = find_corners_manually( dir_name,1,1000 );
load('detection_manually_1_16');


%check_accuracy_of_manually_detection(GT,dir_name,n,m)


[detected_gate] = snake_gate_detection(dir_name);
[corner_error_relative,center_error_relative] = check_max_error_of_automatic_detection(GT,detected_gate);

temp = 1;
