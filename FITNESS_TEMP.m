function f=FITNESS_TEMP(POINTS,DIRECTION,I,J,No_of_cameras)
I1 = imbinarize(I);
I = imcomplement(I);
%J = uint8(round(0.1 *255* imbinarize(J)));
L = J;
[x y] = size(I);
count=0;
Z = I;
Z2 = Z;
for loop = 1 : No_of_cameras
  J = L;
  Z2=Z;
  %disp(POINTS(loop,:));
  point1 = POINTS(loop,:);
  ypoint = point1(1);
  xpoint = point1(2);
%  imshow(J);
  J = imtranslate(J,[ xpoint ypoint ]);
%  imshow(J);
  J = rotateAround(J,ypoint,xpoint,DIRECTION(loop));
  %disp(POINTS(loop,:));
%  imshow(J);
 % J = imresize(J,[x y]);
  Z = imadd(I,J);
  Z1 = immultiply(I1,Z);
  Z=imadd(Z2,Z1);
%  imshow(Z);
  Q = Z;
end

%plot camera_co-ordinates on floor plan
imshow(Z);
numbers=double(unique(Z));
numbers2 = unique(I);
imshow(Z);
var1 = nnz(I == min(numbers2));
var = nnz(Z == max(numbers));
disp('fitness');
disp((var/var1));
f = Z;
return;
