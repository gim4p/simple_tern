

%% der Figge Plot ist eigentlich 1 zu 1 nur Ternplot und Shepard, lediglich Linien integriert und für 1:1 Ratio von FOLK (1954) 

%% Ternplot
% Author: Carl Sandrock 20020827
% Modifiers
% CS Carl Sandrock
% SA Shahab Afshari

%% Shepard
% Author: Carl Sandrock 20020827

%%
clear all; close all; clc;

%% testdata
dummydata_n = 20;
fine_sand = rand(dummydata_n,1);
middle_sand = (1 - fine_sand ) ./ randi(6,dummydata_n,1);
coarse_sand = 1 - (fine_sand+middle_sand);

mud_percent    = fine_sand;
sand_percent   = middle_sand;
gravel_percent = coarse_sand;

%% FIGGE 1981
figure; hold on
simply_figge_tern(fine_sand, middle_sand, coarse_sand,'k.', 'MarkerSize', 25) 
x0=240; y0=350; width=450; height=350; set(gcf,'units','points','position',[x0,y0,width,height]); 

%% FOLK 1954, 1974
figure; hold on;
simply_folk_tern(mud_percent, sand_percent, gravel_percent,'k.', 'MarkerSize', 25);
x0=840; y0=350; width=450; height=350; set(gcf,'units','points','position',[x0,y0,width,height]); 



