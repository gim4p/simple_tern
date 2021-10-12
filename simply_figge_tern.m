%20190704quickplot

function simply_figge_tern(A, B, C, varargin)

%% triangle layout
basis_angle_tern=layout_tern_figge;

%% copy paste of Shepard
% Done picking boundary points
xoffset = 0.04;
yoffset = 0.02;
majors = 4;
Total = (A+B+C);
fA = A./Total;
fB = B./Total;
fC = 1-(fA+fB);
[x, y] = frac2xy(fA, fC, basis_angle_tern);
% Sort data points in x order
[x, i] = sort(x);
y = y(i);
% get hold state
cax = newplot;
next = lower(get(cax,'NextPlot'));
hold_state = ishold;

plot(x,y,varargin{:})

vertexlabl('Middle Sand', 'Coarse Sand', 'Fine Sand'); title('Figge Tern 1981');

function basis_angle_tern=layout_tern_figge

xoffset = 0.06;
yoffset = 0.03;

cax = newplot;
tc = get(cax,'xcolor');
laenge = 1;
hoehe= tand(60)*laenge/2; %1;

plot ([0 laenge laenge/2 0],[0 0 hoehe 0], 'Linewidth', 3, 'color', tc, 'linewidth',1, 'handlevisibility','off');	set(gca, 'visible', 'off');
% patch('xdata', [0 laenge laenge/2 0], 'ydata', [0 0 hoehe 0], 'edgecolor',tc,'facecolor',get(gca,'color'),'handlevisibility','off'); % for multiple serial plots, pathes no good 

basis_angle_tern = atand(hoehe/(laenge/2)); % just makes sense for non equiangular triangles, which is not implemented  

%%
backgroundlines_figge(basis_angle_tern);

%% Generate labels
majorticks = [.1, .4, .6, .9];
labels = num2str(majorticks'*100);

% Plot right labels
[lxa, lya] = frac2xy_lab(1-majorticks,basis_angle_tern);
text(1-lxa+xoffset-0.02, lya, labels);

% Plot left labels
[lxa, lya] = frac2xy_lab(majorticks,basis_angle_tern);
text(lxa-xoffset, lya, labels);

% Plot bottom labels
zerocomp = zeros(1, length(majorticks));
[lxb, lyb] = frac2xy(majorticks, zerocomp,basis_angle_tern); % fA = 1-fB
text(lxb, lyb-yoffset, labels, 'VerticalAlignment', 'Top');

%% separating lines
% horizontal lines
for n = [1,3]
    plot( [lxa(n), 1-lxa(n)] , [lya(n), lya(n)], 'k', 'LineWidth', 1.5)
end
% vertical lines
wert1 = .1 / (1/.5);
plot( [0.4, 0.4 + wert1 ] , [0, lya(1)], 'k', 'LineWidth', 1.5)

%% field labels (kind of Shepard copy)
gS_loc = [.5 .65];
gS_lab = text(gS_loc(1), gS_loc(2),'gS');
set(gS_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
mSgS_loc = [.5 .3];
mSgS_lab = text(mSgS_loc(1), mSgS_loc(2),'mS - gS');
set(mSgS_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
fS_loc = [.2 .04];
fS_lab = text(fS_loc(1), fS_loc(2),'fS');
set(fS_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');
mS_loc = [.72 .04];
mS_lab = text(mS_loc(1), mS_loc(2),'mS');
set(mS_lab,'FontName','Times','FontSize',12,'HorizontalAlignment','center');

function backgroundlines_figge(basis_angle_tern)
majors=10;
majorticks = linspace(0, 1, majors + 1); 
majorticks = majorticks(1:end);

[lxa, lya] = frac2xy_lab(majorticks,basis_angle_tern);
lxb = (lxa + 0.5);
lyb = fliplr(lya);
lxc = majorticks;
lyc = zeros(1, length(majorticks));
lya_flip = fliplr(lya); lxb_flip = fliplr(lxb);

for n = 1 : length(majorticks)
    
    l1 = plot([lxa(n),lxb_flip(n)], [lya(n), lya(n)], 'LineWidth', 0.1, 'Color', 'k');
    l2 = plot([lxc(n),lxb(n)], [lyc(n), lya_flip(n)], 'LineWidth', 0.1, 'Color', 'k');
    l3 = plot([lxc(n),lxa(n)], [lyc(n), lya(n)], 'LineWidth', 0.1, 'Color', 'k');    
    l1.Color(4) = 0.2;l2.Color(4) = 0.2;l3.Color(4) = 0.2;
end

function [x, y] = frac2xy_lab(fC,basis_angle_tern)
y = fC*sind(basis_angle_tern);
x = fC*cosd(basis_angle_tern);

function [x, y] = frac2xy(fA, fC, basis_angle_tern)
%-----------------------------------------%
% Support Functions frac2xy and radians
y = fC*sin(radians(basis_angle_tern));
x = 1 - fA - y*cot(radians(basis_angle_tern));

function radians = radians(degrees)
radians = ((2*pi)/360)*degrees;

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
