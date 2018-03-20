close all;
clear all
global sample_num FIGURE minimun_length color_fitness_threshold

dir_name = 'basement';
FIGURE = 0;
% [ GT_gate ] = find_corners_manually( dir_name,0,1000 );
 load('3_19_GT_gate');
% load('GT_basement');
%check_accuracy_of_manually_detection(GT_gate,dir_name,0,1000);

%check_accuracy_of_manually_detection(GT,dir_name,n,m)
%[corner_error_relative,center_error_relative] = check_max_error_of_automatic_detection(GT,detected_gate);
%load('2018_2_5_GT_with_SG');
%[distance] = distribution_of_distance_from_gate(GT_gate);
n = 1;
m = 1;

for i = 1:11
   ROC(i).TP = 0;
   ROC(i).FP = 0;
   ROC(i).FN = 0;
end

TP_rate_mean = zeros(m-n+1,1);
FP_rate_mean = zeros(m-n+1,1);
TP_rate_std = zeros(m-n+1,1);
FP_rate_std = zeros(m-n+1,1);

ROC_statistic = cell(m-n+1,1);

max_iter = 10;

for i = n:m
    i
    minimun_length = 35;
    color_fitness_threshold = 0.7;
    sample_num = 1000;
    [detected_gate,gates_candidate_corners] = snake_gate_detection(dir_name,0,1000);

    [refined_gate_candidates,refined_gate_candidates_cf] = refine_gate_candidates(gates_candidate_corners);
    
    [ROC] = count_ROC_term_with_refined_candidates(GT_gate,refined_gate_candidates_cf,ROC);
    
end


figure(10)
grid on
for i = 1:size(ROC,2)
   x(i) = 0.02*i;
   TPR(i) = ROC(i).TP/(ROC(i).TP+ROC(i).FN);
end
plot(x,TPR);
xlabel('distance');
ylabel('True Positive rate');
temp = 1;
