function [intensity] = fourierprop2D(U,z,lambda,unit)
% 2D fourier propagation method test (based on Goodman Fourier Optics eqn. 4-17)
% Borrowed from Steve Elston, adapted by Camron Nourshargh
%
% Inputs
% U --------- input field (can be anything we want it to be, varying in phase and amplitude)
% z --------- propagation distance in metres
% lambda ---- wavelength of light
% unit ------ step size of input array in metres
%
% Outputs
% intensity - intensity profile of far diffraction pattern


%% define input values and matrices 

k=2*pi/lambda;                              % wavenumber of light
                                            
[nx,ny] = size(U);                          % determine dimensions of Incident field
x = linspace(-0.5*unit*nx,0.5*unit*nx,nx);  % represents X position across input matrix
y = linspace(-0.5*unit*ny,0.5*unit*ny,ny);  % represents Y position across input matrix
[X,Y] = meshgrid(x,y);                      % creates matrices of X and Y coordinates across input


%% create output length scale and array from delta_x_out = (z*lambda)/(n*delta_x_in)

unit_out=(z*lambda)/(max([nx ny])*unit);                % step size of output array in metres
x_out = linspace(-0.5*unit_out*nx,0.5*unit_out*nx,nx);  % represents X position across output array
y_out = linspace(-0.5*unit_out*ny,0.5*unit_out*ny,ny);  % represents Y position across output array
[X_out,Y_out] = meshgrid(x_out,y_out);                  % creates matrices of X and Y coordinates across output
                                                        % note: total width of output array space = (z*lambda)/delta_x_in

%% propagate U - this section "runs" Goodman Fourier Optics eqn. 4-17

U_prop=U.*exp(0.5*1i*(k/z).*(X.*X+Y.*Y));                               % multiply U by the phase factor inside the curly brackets
U_out=fft2(U_prop);                                                     % fourier transform
U_out=ifftshift(U_out);                                                 % re-centre result of fourier transform
U_out_phase=U_out.*exp(0.5*1i*(k/z).*(X_out.*X_out+Y_out.*Y_out));      % multiply by the phase factor infront of the integral

%% get intensity of output for plotting...
intensity=abs(U_out_phase.*U_out_phase);                                % intensity calc.

%% plot
figure;
surf(x,y,angle(U),'linestyle','none');                  % Plot input phase profile
title('Incedent phase profile')
xlabel('X/ metres') 
ylabel('Y/ metres') 
colorbar;
view(2);

figure;
surf(x,y,abs(U.*U),'linestyle','none');                 % plot input intensity profile
title('Incedent Intensity profile')
xlabel('X/ metres') 
ylabel('Y/ metres') 
colorbar;
view(2);

figure
surf(x_out,y_out,intensity,'linestyle','none');         % Plot output intensity profile
title('Diffraction intensity profile')
xlabel('X/ metres') 
ylabel('Y/ metres') 
colorbar;
view(2);

figure
surf(x_out,y_out,angle(U_out_phase),'linestyle','none');% Plot output phase profile
title('Diffraction Phase profile')
xlabel('X/ metres') 
ylabel('Y/ metres') 
colorbar;
view(2);