function plot_wake(x_root,y_root,z_root,x_tip,y_tip,z_tip,option)
switch option
  case 1    % Tip wake
    plot3(x_tip,y_tip,z_tip,'b-');
    grid on;
    axis vis3d;
    
  case 2    % Root wake
    plot3(x_root,y_root,z_root,'r-');
    grid on;
    axis vis3d;
    
  case 3    % Tip and root wake
    plot3(x_tip,y_tip,z_tip,'b-');
    hold on;
    plot3(x_root,y_root,z_root,'r-');
    grid on;
    axis vis3d;
    
  case 4    % Tip, root wake and intermediate lines
    plot3(x_tip,y_tip,z_tip,'b-');
    hold on;
    plot3(x_root,y_root,z_root,'r-');
    
    for i=1:length(x_tip)
      line([x_root(i) x_tip(i)],[y_root(i) y_tip(i)],[z_root(i) z_tip(i)]);
    end
    grid on;
    axis vis3d;
    
  otherwise
    disp('ERROR: WRONG OPTION FOR plot_wake');
end

return;