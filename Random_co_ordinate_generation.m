function f = Random_co_ordinate_generation(Floor_plan,Camera_coverage,No_of_cameras)
Floorplan_temp = Floor_plan;
Floorplan_temp = im2bw(Floorplan_temp);
[x_floorplan,y_floorplan] = size(Floorplan_temp);
c=1;
for j = 1 : No_of_cameras
        while (1) 
          posx = randi(x_floorplan);
          posy = randi(y_floorplan);
          if(Floorplan_temp(posx,posy) == 1)
              b = [posx  posy];       
              if(c == 1)
                  c=0;
              end
              camera_co_ordinates (j,:) = b;
              break;
          end
        end
end
directions_camera = randi([0 360],No_of_cameras,1);
%plot camera_co-ordinates on floor plan
%for j= 1: No_of_cameras
%  point1 = camera_co_ordinates(j,:);
%  x = point1(1);
%  y = point1(2);
%hold on; 
%plot(y,x,'r+', 'MarkerSize', 50);
%end
%hold off
f = horzcat(camera_co_ordinates,directions_camera);
%FITNESSFN(camera_co_ordinates,directions_camera,Floor_plan,Camera_coverage);
end