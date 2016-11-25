function f = boundary(Floor_plan,x,y)
Floor_plan = imread('BLACK.png'); % provide path of floorplan
Floor_plan = rgb2gray(Floor_plan); % Converting images to grayscale
binaryImage =  imbinarize(Floor_plan);
boundaries = bwboundaries(binaryImage);
for b = 1 : length(boundaries)
   thisBoundaryX = boundaries{b}(:, 1);
   thisBoundaryY = boundaries{b}(:, 2);
   distances = sqrt((thisBoundaryX - x).^2 + (thisBoundaryY - y).^2);
   [minDistance, indexOfMin] = min(distances);
end
f = [ thisBoundaryX(indexOfMin),thisBoundaryY(indexOfMin) ];