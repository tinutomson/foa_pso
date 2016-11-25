%LB=[0 0 0];         		%lower bounds of variables 
%UB=[10 10 10];      		%upper bounds of variables   

clc;
close all;
clear all;
N = 5;
B = zeros(5,3,N);
Floor_plan = imread('BLACK.png'); % provide path of floorplan
Camera_coverage = imread('cam.png'); % provide path of camera coverage
Floor_plan = rgb2gray(Floor_plan); % Converting images to grayscale
Camera_coverage = rgb2gray(Camera_coverage);
figure
% pso parameters values 

no_of_dim=3;            	% number of variables 
no_of_particles=100;        % population size
no_of_cameras=22;            % number of cameras
weight_max=0.9;       		% inertia weight 
weight_min=0.4;       		% inertia weight 
acceleration1=0.2;           	% acceleration factor 
acceleration2=0.01;           	% acceleration factor



% pso main program----------------------------------------------------start 

max_iteration=20;         % set maximum number of iteration  
max_run=10;                 % set maximum number of runs need to be 
%for run=1:max_run        
	% pso initialization----------------------------------------------start     
    for particle=1:no_of_particles         
        particles (:,:,particle) = Random_co_ordinate_generation(Floor_plan, Camera_coverage, no_of_cameras);
        % disp(particle);
    end     
	temp_particles = particles;                 % initial population     
	
    v=0.01*temp_particles;               % initial velocity     
    for particle=1:no_of_particles
       camera_co_ordinates = particles(:,:,particle);
       camera_co_ordinate = horzcat(camera_co_ordinates(:,1),camera_co_ordinates(:,2));
       directions_camera = camera_co_ordinates(:,3);
       fitness_values(particle)=fitnessfunction(camera_co_ordinate,directions_camera,Floor_plan,Camera_coverage,no_of_cameras);
       % disp(particle);
    end
    
    [fitness_values0,index0]=max(fitness_values);         
	pbest=particles;               % initial pbest     
	gbest=particles(:,:,index0);   % initial gbest     
%    camera_co_ordinate = horzcat(camera_co_ordinates(:,1),camera_co_ordinates(:,2));
%    directions_camera = camera_co_ordinates(:,3);
%    FITNESS_TEMP(camera_co_ordinate,directions_camera,Floor_plan,Camera_coverage)
    
    % pso algorithm---------------------------------------------------start     
    
    camera_co_ordinates = gbest;
    camera_co_ordinate = horzcat(camera_co_ordinates(:,1),camera_co_ordinates(:,2));
    directions_camera = camera_co_ordinates(:,3);
    FITNESS_TEMP(camera_co_ordinate,directions_camera,Floor_plan,Camera_coverage,no_of_cameras);
    
    iteration=1; 
    pos_iterate = 1;
    while(pos_iterate<10)
    while iteration<=max_iteration
        
        weight=weight_max-(weight_max-weight_min)*iteration/max_iteration; 		% update inertial weight           
	
	% pso velocity updates         
		for i=1:no_of_particles            
			for j=1:no_of_cameras
                for k=1:3
                a0= weight*v(j,k,i);
                part = temp_particles(j,k,i);
                a1 = acceleration1*(rand()/2)*(gbest(j,k)-temp_particles(j,k,i));    
                a2 = acceleration2*(rand()/2)*(pbest(j,k,i)-temp_particles(j,k,i));
				v(j,k,i)=a0+a1+a2;                             
                end         
		    end           
        end

% pso position update         
	for i=1:no_of_particles             
		for j=1:no_of_cameras
			temp_particles(j,:,i)=temp_particles(j,:,i)+v(j,:,i);             
		end         
    end 
    for i=1:no_of_particles             
		for j=1:no_of_cameras   
            a1=round(temp_particles(j,1,i));
            a2=round(temp_particles(j,2,i));
            [ xsize ysize ] = size(Floor_plan);
            if (a1 > ysize)
               a1= min(xsize,ysize)-5;
            end
            if (a1 < 0)
               a1 = 1;
            end
            if (a2 < 0)
               a2 = 1;
            end
            if (a2 > xsize)
               a2= min(xsize,ysize)-5;
            end
			[temp_particles(j,1,i), temp_particles(j,2,i)] = getPositionOnFloorPlan(Floor_plan, a1, a2); 
            if(temp_particles(j,3,i)>= 360)
                temp_particles(j,3,i)=mod(temp_particles(j,3,i),360);
            end
		end         
	end      
    % evaluating fitness         
	for particle =1:no_of_particles  
        camera_co_ordinates = temp_particles(:,:,particle);
        camera_co_ordinate = horzcat(camera_co_ordinates(:,1),camera_co_ordinates(:,2));
        directions_camera = camera_co_ordinates(:,3);
		fitness_values1(particle)=fitnessfunction(camera_co_ordinate,directions_camera,Floor_plan,Camera_coverage,no_of_cameras);         
    end
       
    % updating pbest and fitness         
	for particle=1:no_of_particles  
            if fitness_values1(particle)>fitness_values(particle) 
                pbest(:,:,particle)=temp_particles(:,:,particle);
                fitness_values(particle)=fitness_values1(particle);             
		    end 
    end
    
    [fmax,ind] = max(fitness_values);
    if( fmax > fitness_values0)
        gbest = pbest(:,:,ind);
        fitness_values0 =  fmax;
    end
    
    camera_co = gbest;
    camera_cor = horzcat(camera_co(:,1),camera_co(:,2));
    directions_c = camera_co(:,3);
    FITNESS_TEMP(camera_cor,directions_c,Floor_plan,Camera_coverage,no_of_cameras);
    pos_iterate = pos_iterate + 1;
    iteration = 1;
    iteration = iteration + 1;
    end
    
    camera_co_ordinates = gbest;
    camera_co_ordinate = horzcat(camera_co_ordinates(:,1),camera_co_ordinates(:,2));
    directions_camera = camera_co_ordinates(:,3);
    FITNESS_TEMP(camera_co_ordinate,directions_camera,Floor_plan,Camera_coverage,no_of_cameras);
    pos_iterate = pos_iterate + 1;
    iteration = 1;
    end
 
    
