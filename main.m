clc;
close all;
clear all;
N = 5;
B = zeros(5,3,N);
Floor_plan = imread('BLACK.png'); % provide path of floorplan
Camera_coverage = imread('cam.png'); % provide path of camera coverage
Floor_plan = rgb2gray(Floor_plan); % Converting images to grayscale
Camera_coverage = rgb2gray(Camera_coverage);
for i = 1: N
A = Random_co_ordinate_generation(Floor_plan,Camera_coverage);
end

