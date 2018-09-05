function plot_wake(x_root,y_root,z_root,x_tip,y_tip,z_tip,option)
switch option
  case 1    % Tip wake
    plot3(x_tip,y_tip,z_tip,'b-');
    
  case 2    % Root wake
    plot3(x_root,y_root,z_root,'m-');
    
  case 3    % Tip and root wake
    plot3(x_tip,y_tip,z_tip,'b-');
    hold on;
    plot3(x_root,y_root,z_root,'m-');
    
  case 4    % Tip, root wake and intermediate lines
    plot3(x_tip,y_tip,z_tip,'b-');
    hold on;
    plot3(x_root,y_root,z_root,'m-');
    for i=1:length(x_tip)
      line([x_root(i) x_tip(i)],[y_root(i) y_tip(i)],[z_root(i) z_tip(i)]);
    end
    
  case 5    % Tip, root wake and intermediate lines for TWO blades
    plot3(x_tip,y_tip,z_tip,'b-');
    hold on;
    plot3(x_root,y_root,z_root,'m-');
    for i=1:length(x_tip)
      line([x_root(i) x_tip(i)],[y_root(i) y_tip(i)],[z_root(i) z_tip(i)]);
    end
    
    % Second blade
    plot3(-x_tip,-y_tip,z_tip,'b-');
    plot3(-x_root,-y_root,z_root,'m-');
    for i=1:length(x_tip)
      line([-x_root(i) -x_tip(i)],[-y_root(i) -y_tip(i)],[z_root(i) z_tip(i)],'Color','g');
    end
    
  otherwise
    disp('ERROR: WRONG OPTION FOR plot_wake');
end

% Plot blade location
hold on
line([0 x_tip(1)],[0 y_tip(1)],[0 z_tip(1)],'Color','red','LineWidth',1.5);

if (option==5)
  line([0 -x_tip(1)],[0 -y_tip(1)],[0 z_tip(1)],'Color','red','LineWidth',1.5);
end

grid on;
axis equal;
xlabel('X/R');
ylabel('Y/R');

return;