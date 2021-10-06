
function simply_folk_tern(mud, sand, gravel, varargin)

%% triangle layout
layout_tern_folk

%%
frac_sand_mudsandsum = sand./(mud+sand);
gravel = ((tand(60)*0.5)/1)*gravel;  % 1 is shorter because of equiangular triangle  

%% SYMS
%{
figure; hold on
plot ([0 1 0.5 0],[0 0 1 0])
y=gravel_percent_all;
for sample = 1 : length(gravel_percent_all)
    syms x_syms
    leftaxis = 2*x_syms;
    rightaxis = -2*x_syms + 2;
    start_val = double(solve(leftaxis == y)); 
    stop_val = double(solve(rightaxis == y));
    length_new = abs(start_val-stop_val);
    x_new = start_val + length_new * frac_mud_mud2sand;
    plot(x_new, y, '.')
end
%}

%% no SYMS -> able to export  
A_Y = 0; A_X = 0;
B_Y = tand(60)/2; B_X = 0.5;

axislgth = sqrt(B_X^2+B_Y);
AB_left = [ B_Y - 0 ; B_X - 0 ];
AB_right = [ 0 - B_Y ; 1 - B_X ];
einheitsvec_left = (1/axislgth).*AB_left;
einheitsvec_right = (1/axislgth).*AB_right;

dumpcount=1;
for pt_on_axis = 0 : .01 : axislgth % discretized 

    point_on_axis_left(:,dumpcount) =  [A_Y + pt_on_axis * einheitsvec_left(1)  ; A_X + pt_on_axis * einheitsvec_left(2) ]; 
    point_on_axis_right(:,dumpcount) = [B_Y + pt_on_axis * einheitsvec_right(1) ; B_X + pt_on_axis * einheitsvec_right(2)]; 

    dumpcount=dumpcount+1;
end

% figure; hold on
% plot(point_on_axis_left(2,:),point_on_axis_left(1,:),'*')
% plot(point_on_axis_right(2,:),point_on_axis_right(1,:),'*')

for sample = 1 : length(gravel)

    if isnan(gravel(sample))~=1

        difference_left = abs(point_on_axis_left(1,:) - gravel(sample));
        difference_right = abs(point_on_axis_right(1,:) - gravel(sample));

        difference_sort_left = sort(difference_left);
        difference_sort_right = sort(difference_right);

        pos_left = find(difference_left == difference_sort_left(1));
        pos_right = find(difference_right == difference_sort_right(1));

        start_val = point_on_axis_left(2,pos_left);
        stop_val = point_on_axis_right(2,pos_right);
        length_new = abs(start_val-stop_val);
        x_new = start_val + length_new * frac_sand_mudsandsum(sample);

        plot(x_new,gravel(sample), varargin{:}); % legend specification missing 
    end
end

vertexlabl('Sand', 'Gravel', 'Mud'); title('Folk Tern (1954, 1974)');


function layout_tern_folk
xoffset = 0.05;
yoffset = 0.03;
laenge = 1;
cax = newplot; tc = get(cax,'xcolor');
hoehe= tand(60)*laenge/2; %1;

plot ([0 laenge laenge/2 0],[0 0 hoehe 0], 'LineWidth', 3, 'color', tc, 'linewidth',1, 'handlevisibility','off');	
set(gca, 'visible', 'off');
% patch('xdata', [0 laenge laenge/2 0], 'ydata', [0 0 hoehe 0], 'edgecolor',tc,'facecolor',get(gca,'color'),'handlevisibility','off'); % for multiple serial plots, pathes no good 
 

basis_angle_tern = atand(hoehe/(laenge/2)); % just makes sense for non equiangular triangles, which is not implemented  

%% Generate labels
majorticks = [.05,.3,.8];
labels = num2str(majorticks'*100);

% Plot left labels
[lxa, lya] = frac2xy_lab(majorticks,basis_angle_tern);
text(lxa-xoffset, lya, labels);

% Plot bottom labels
x_tic = [.1, .5, .9];
text(x_tic, zeros(1,3)-yoffset, ['1:9';'1:1';'9:1'], 'VerticalAlignment', 'Top')

%% separating lines
% horizontale linien
for n = 1 : length(lxa)
    plot( [lxa(n), 1-lxa(n)] , [lya(n), lya(n)], 'k', 'LineWidth', 1.5)
end

% vertikale linien
wert1 = majorticks(1) / (1/(.5-x_tic(1)));
plot( [x_tic(1), x_tic(1) + wert1 ] , [0, lya(1)], 'k', 'LineWidth', 1.5)

plot( [x_tic(2),x_tic(2)], [0, lya(3)], 'k', 'LineWidth', 1.5)

wert2 = majorticks(3) / (1/(x_tic(3)-.5));
plot( [x_tic(3),x_tic(3)-wert2], [0, lya(3)], 'k', 'LineWidth', 1.5)

%% field labels (Shepard copy)
G_loc = [.5 .75];
G_lab = text(G_loc(1), G_loc(2),'G');
set(G_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
mG_loc = [.37 .41];
mG_lab = text(mG_loc(1), mG_loc(2),'mG');
set(mG_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
msG_loc = [.61 .41];
msG_lab = text(msG_loc(1), msG_loc(2),'msG');
set(msG_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
sG_loc = [.738 .41];
sG_lab = text(sG_loc(1), sG_loc(2),'sG');
set(sG_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
gM_loc = [.26 .15];
gM_lab = text(gM_loc(1), gM_loc(2),'gM');
set(gM_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
gmS_loc = [.68 .15];
gmS_lab = text(gmS_loc(1), gmS_loc(2),'gmS');
set(gmS_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
gS_loc = [.875 .15];
gS_lab = text(gS_loc(1), gS_loc(2),'gS');
set(gS_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
M_loc = [.06 .02];
M_lab = text(M_loc(1), M_loc(2),'M');
set(M_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
sM_loc = [.3 .02];
sM_lab = text(sM_loc(1), sM_loc(2),'sM');
set(sM_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
mS_loc = [.7 .02];
mS_lab = text(mS_loc(1), mS_loc(2),'mS');
set(mS_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
S_loc = [.95 .02];
S_lab = text(S_loc(1), S_loc(2),'S');
set(S_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');

function [x, y] = frac2xy_lab(fC,basis_angle_tern)
y = fC*sind(basis_angle_tern);
x = fC*cosd(basis_angle_tern);

function h = vertexlabl(A, B, C, offset)
% Author: Peter Selkin 20030508 Modified from Carl Sandrock 20020827 (ternplot) 

if (nargin~=4)
	offset=0.03;
end

r(1) = text(-offset, -offset, C, 'horizontalalignment', 'right');
r(2) = text(1+offset, -offset, A, 'horizontalalignment', 'left');
r(3) = text(0.5, sin(deg2rad(60))+.04, B, 'horizontalalignment', 'center');

if nargout > 0
    h = r;
end;
