close all;
clear all
global sample_num FIGURE minimun_length

dir_name = 'pic_cyberzoo';
FIGURE = 0;
% [ GT_gate ] = find_corners_manually( dir_name,0,1000 );
 load('2018_2_2_ground_truth_gate_selection');
%check_accuracy_of_manually_detection(GT_gate,dir_name,0,1000);
p = 1;
%check_accuracy_of_manually_detection(GT,dir_name,n,m)
%[corner_error_relative,center_error_relative] = check_max_error_of_automatic_detection(GT,detected_gate);
%load('2018_2_5_GT_with_SG');

n = 1;
m = 20;
TPR = zeros(m-n+1,1);
FPR = zeros(m-n+1,1);
TP = zeros(m-n+1,1);
FP = zeros(m-n+1,1);
TN = zeros(m-n+1,1);
FN = zeros(m-n+1,1);
for i = n:m
    i
    minimun_length = (i-1)*5;
    sample_num = i*1000;
 [detected_gate,gates_candidate_corners] = snake_gate_detection(dir_name,0,1000);
 %load('2018_2_7_autonomous_detection_temp');
 %load('2018_2_7_autonomous_detection_temp_2');
 [True_Positive,False_Positive, False_Negative,True_Negative] =...
     count_4_category(dir_name,0,1000,GT_gate,gates_candidate_corners,detected_gate);
% [True_Positive,False_Positive, False_Negative,True_Negative] = ...
%     check_auto_detection_accuracy(dir_name,0,1000,GT_gate,detected_gate);
% TP(i) = True_Positive
% FP(i) = False_Positive
% TN(i) = True_Negative
% FN(i) =  False_Negative

% temp1 = True_Positive/( True_Positive+False_Negative)
% temp2 = False_Positive/( False_Positive+True_Negative)
TPR(i) = True_Positive/( True_Positive+False_Negative);
FPR(i) =  False_Positive/( False_Positive+True_Negative);
p = p + 1;
end
figure(10)
plot( FPR, TPR,'*');
grid on
xlabel('False Positive rate');
ylabel('True Positive rate');
temp = 1;
