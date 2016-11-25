function f = fitnessfunction(camera_co_ordinates,directions_camera,Floor_plan,Camera_coverage,no_of_cameras)
Bin_image = imbinarize(Floor_plan);  % Convert image to binary
Floor_plan = imcomplement(Floor_plan); % Complement the image
L = Camera_coverage; 
Z = Floor_plan;
for loop = 1 : no_of_cameras 
  Camera_coverage = L;
  Z2=Z;
  point1 = camera_co_ordinates(loop,:); 
  ypoint = point1(1); 
  xpoint = point1(2); 
  %imshow(Camera_coverage);
  Camera_coverage = imtranslate(Camera_coverage,[ xpoint ypoint ]); % move to camera position
  %imshow(Camera_coverage);
  Camera_coverage = rotateAround(Camera_coverage,ypoint,xpoint,directions_camera(loop)); % consider direction
  %imshow(Camera_coverage);
  Z = imadd(Floor_plan,Camera_coverage); % add camera coverage and floor plan
  Z1 = immultiply(Bin_image,Z); 
  Z=imadd(Z2,Z1);
  %imshow(Z);
end

numbers=double(unique(Z));
numbers2 = unique(Floor_plan);
%imshow(Z);
var1 = nnz(Floor_plan == min(numbers2));
var = nnz(Z == max(numbers));
disp((var/var1));
f = var/var1; % output ratio