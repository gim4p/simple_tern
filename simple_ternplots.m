

%% actually, I just copied Shepard ternery plot and only inserted lines and fraction 
% borders for quickly plotting grabsamples data into Figge and Folkk ternplots
% simply_figge_tern and simply_folk_tern are the two functions

%% Ternplot (Shepard ternery plot)
% Author: Carl Sandrock 20020827
% Modifiers: CS Carl Sandrock and SA Shahab Afshari

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



