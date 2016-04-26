clear all
close all


% ------ %
% test 1 %
% ------ %

% load data
load('test_1.mat');

% default marker properties
figure
ax = gca;
marker = 'osd^v><ph+*.x';
marker_edge_color = ax.ColorOrder;
marker_face_color = ax.ColorOrder;
close

% draw normalized Taylor diagram
norm_taylor_diag(ts);
                       
% legend
n = 0;
for k = 1:length(ts)
    n = n + 1;
    h(n) = plot(-1, -1);
    h(n).LineStyle = 'none';
    h(n).Marker = marker(k);
    h(n).MarkerFaceColor = 'w';
    h(n).MarkerEdgeColor = 'k';
end
for k = 2:size(ts{1}, 2)
    n = n + 1
    h(n) = plot(-1, -1);
    h(n).LineStyle = 'none';
    h(n).Marker = 'o';
    h(n).MarkerFaceColor = marker_face_color(k - 1, :);
    h(n).MarkerEdgeColor = marker_edge_color(k - 1, :);
end

h = legend(h);
h.String{ 1} = 'Appelzak';
h.String{ 2} = 'Bol van Heist';
h.String{ 3} = 'Bol van Knokke';
h.String{ 4} = 'Nieuwpoort';
h.String{ 5} = 'Oostende';
h.String{ 6} = 'Wandelaar';
h.String{ 7} = 'Westhinder';
h.String{ 8} = 'Zeebrugge';
h.String{ 9} = 'Grid A';
h.String{10} = 'Grid B';
h.String{11} = 'Grid C';
h.String{12} = 'Grid D';
h.String{13} = 'Grid E';
h.String{14} = 'Grid F';
h.String{15} = 'Grid G';
h.Location = 'NorthEastOutside';