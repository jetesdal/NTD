clear all
close all


% ------ %
% test 1 %
% ------ %

% load data
load('test_1.mat');

% markers
for i =  2:10:32; marker{i} = 'o'; end;
for i =  3:10:33; marker{i} = 's'; end;
for i =  4:10:34; marker{i} = 'd'; end;
for i =  5:10:35; marker{i} = '^'; end;
for i =  6:10:36; marker{i} = 'v'; end;
for i =  7:10:37; marker{i} = '>'; end;
for i =  8:10:38; marker{i} = '<'; end;
for i =  9:10:39; marker{i} = 'p'; end;
for i = 10:10:40; marker{i} = 'h'; end;

% get color order
figure
ax = gca;
color_order = ax.ColorOrder;
close

% marker face colors
for i =  1:10; marker_face_color{i} = color_order(2, :); end
for i = 11:20; marker_face_color{i} = color_order(4, :); end
for i = 21:30; marker_face_color{i} = color_order(5, :); end
for i = 31:40; marker_face_color{i} = color_order(6, :); end

% draw normalized Taylor diagram
norm_taylor_diag(mat, ref, 'Marker', marker, ...
                           'MarkerFaceColor', marker_face_color);
                       
% legend
for i = 1:13
    h(i) = plot(2, 2);
end

for i = 1:4
    h(i).LineStyle = 'none';
    h(i).Marker = 'o';
    h(i).MarkerFaceColor = marker_face_color{i * 10};
    h(i).MarkerEdgeColor = marker_face_color{i * 10};
end

for i = 5:13
    h(i).LineStyle = 'none';
    h(i).Marker = marker{i - 3};
    h(i).MarkerFaceColor = 'none';
    h(i).MarkerEdgeColor = 'k';
end

h = legend(h);
h.String{ 1} = 'Appelzak';
h.String{ 2} = 'Bol van Heist';
h.String{ 3} = 'Bol van Knokke';
h.String{ 4} = 'Wandelaar';
h.String{ 5} = 'Grid A';
h.String{ 6} = 'Grid B';
h.String{ 7} = 'Grid C';
h.String{ 8} = 'Grid D';
h.String{ 9} = 'Grid E';
h.String{10} = 'Grid F';
h.String{11} = 'Grid G';
h.String{12} = 'Grid H';
h.String{13} = 'Grid I';
h.Location = 'NorthEastOutside';