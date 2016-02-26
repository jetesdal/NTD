clear all
close all


% ------ %
% test 1 %
% ------ %

% load data
load('test_1.mat');

% markers
for i =  9:16; marker{i} = 'o'; end;
for i = 17:24; marker{i} = 's'; end;
for i = 25:32; marker{i} = 'd'; end;
for i = 33:40; marker{i} = '^'; end;
for i = 41:48; marker{i} = 'v'; end;
for i = 49:56; marker{i} = '>'; end;
for i = 57:64; marker{i} = '<'; end;
for i = 65:72; marker{i} = 'p'; end;
for i = 73:80; marker{i} = 'h'; end;

% get color order
figure
ax = gca;
color_order = ax.ColorOrder;
close

% marker face colors
for i =  9:8:80; marker_face_color{i} = color_order(1, :); end
for i = 10:8:80; marker_face_color{i} = color_order(2, :); end
for i = 11:8:80; marker_face_color{i} = color_order(3, :); end
for i = 12:8:80; marker_face_color{i} = color_order(4, :); end
for i = 13:8:80; marker_face_color{i} = color_order(5, :); end
for i = 14:8:80; marker_face_color{i} = color_order(6, :); end
for i = 15:8:80; marker_face_color{i} = [0 0 0]; end
for i = 16:8:80; marker_face_color{i} = color_order(7, :); end

% draw normalized Taylor diagram
norm_taylor_diag(mat, ref, 'Marker', marker, ...
                           'MarkerFaceColor', marker_face_color);
                       
% legend
for i = 1:17
    h(i) = plot(2, 2);
end

for i = 1:17
    h(i).LineStyle = 'none';
    h(i).Marker = 'o';
    h(i).MarkerFaceColor = marker_face_color{i + 8};
    h(i).MarkerEdgeColor = marker_face_color{i + 8};
end

for i = 9:17
    h(i).LineStyle = 'none';
    h(i).Marker = marker{(i - 8) * 8 + 1};
    h(i).MarkerFaceColor = 'none';
    h(i).MarkerEdgeColor = 'k';
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
h.String{16} = 'Grid H';
h.String{17} = 'Grid I';
h.Location = 'NorthEastOutside';