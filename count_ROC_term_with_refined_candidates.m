function [ROC] = count_ROC_term_with_refined_candidates(GT,RF,ROC)
% This function is used to count 4 terms for ROC curve

THRESH = 0.3;
FIGURE = 0;
color = 'r';
p = 1;

dir_name = 'pic_cyberzoo';
for k = 0:1000
    file_name = [dir_name '/' 'img_' sprintf('%05d',k) '.jpg'];
    if ~exist(file_name, 'file')
        continue;
    else
        
        if GT(p,1) == 1 && ~isempty(RF{p})
            [group_id,distance] = calculate_distance_and_group_id(GT(p,:));
            flag_already_TP = 0;  % there is already a TP
            for j = 1:size(RF{p},1)
                if is_two_polygon_similar(GT(p,2:9),RF{p}(j,:),THRESH)
                    if flag_already_TP == 0
                        ROC(group_id).TP = ROC(group_id).TP+1;
                        flag_already_TP = 1;
                    end
                    if FIGURE == 1
                        plot_and_label_candidates(RF{p}(j,:),'TP',2,color)
                    end
                else
                    ROC(group_id).FP = ROC(group_id).FP + 1;
                    if FIGURE == 1
                        plot_and_label_candidates(RF{p}(j,:),'FP',2,color)
                    end
                end
            end
            if  flag_already_TP == 0
                ROC(group_id).FN = ROC(group_id).FN + 1;
                if FIGURE == 1
                    plot_and_label_candidates(GT(p,2:9),'FN',2,'b');
                end
            end
        elseif GT(p,1) == 1 && isempty(RF{p})
            [group_id,distance] = calculate_distance_and_group_id(GT(p,:));
            ROC(group_id).FN = ROC(group_id).FN + 1;
            if FIGURE == 1
                plot_and_label_candidates(zeros(1,8),'FN',2,color)
            end
        end
        
        p = p+ 1;
    end
end
end

function [] = plot_and_label_candidates(coor,label,figure_num,color)
% This function is used to plot raw gates candidates and
% gates after clustering
linewidth = 1;
%color = 'r';
figure(figure_num)

[x_center,y_center] = polyxpoly([coor(1) coor(3)],[coor(5) coor(7)], ...
    [coor(2) coor(4)],[coor(6) coor(8)]);

plot_square(coor,color,linewidth,figure_num);
text(x_center,y_center,label);
end

function [] = plot_square(coor,color,linewidth,figure_num)
figure(figure_num)
plot([coor(1) coor(2)],[coor(5) coor(6)],color,'LineWidth',linewidth);
plot([coor(2) coor(3)],[coor(6) coor(7)],color,'LineWidth',linewidth);
plot([coor(3) coor(4)],[coor(7) coor(8)],color,'LineWidth',linewidth);
plot([coor(4) coor(1)],[coor(8) coor(5)],color,'LineWidth',linewidth);
end
