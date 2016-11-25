function [A,B] = getPositionOnFloorPlan(floor_plan,y, x)
    Floorplan_temp = floor_plan;
    Floorplan_temp = im2bw(Floorplan_temp);
    if(Floorplan_temp(x,y) == 1)
        A = x;
        B = y;
        f = [x , y];
        return
    else
        binaryImage =  imbinarize(floor_plan);
        boundaries = bwboundaries(binaryImage);
        for b = 1 : length(boundaries)
           thisBoundaryX = boundaries{b}(:, 1);
           thisBoundaryY = boundaries{b}(:, 2);
           distances = sqrt((thisBoundaryX - x).^2 + (thisBoundaryY - y).^2);
           [minDistance, indexOfMin] = min(distances);
        end
        A=thisBoundaryX(indexOfMin);
        B=thisBoundaryY(indexOfMin);
        return
    end