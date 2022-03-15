function [intensity] = fourierprop2D(U,z,lambda,unit)
% 2D fourier propagation method test (based on Goodman Fourier Optics eqn. 4-17)
% Borrowed from Steve Elston, adapeted by Camron Nourshargh
%
% Inputs
% U --------- input field (can be anything we want it to be, varying in phase and amplitude)
% z --------- propagation distance in metres
% lambda ---- wavelength of light
% unit ------ step size of input array in metres

% % define some general things
% lambda=500e-09; % wavelength of light in metres
k=2*pi/lambda; % wavenumber of light
% unit=0.5e-06; % step size of input array in metres

% % define some specific values
% z=200e-2; % propagation distance in metres
% n=200; % no of steps in input array (physical total input width with be = n*unit)

[nx,ny] = size(U);
x = linspace(-0.5*unit*nx,0.5*unit*nx,nx); % represents position across input array
y = linspace(-0.5*unit*ny,0.5*unit*ny,ny); 
[X,Y] = meshgrid(x,y);
%x_square=x.*x; % element by element square of the above - not used here

% create output length scale and array from delta_x_out = (z*lambda)/(n*delta_x_in)
unit_out=(z*lambda)/(max([nx ny])*unit); % step size of output array in metres
x_out = linspace(-0.5*unit_out*nx,0.5*unit_out*nx,nx); % represents position across output array
y_out = linspace(-0.5*unit_out*ny,0.5*unit_out*ny,ny);
[X_out,Y_out] = meshgrid(x_out,y_out);
% note: total width of output array space = (z*lambda)/delta_x_in

% setp up an input field "U" (this can be anything we want....)
% U=zeros(nx,ny);
% for i=1:nx % goes up to 1000 here, so fills half the input space
%     for j = 1:n
%         U(i,j)=exp(1i*pi*(cos(x(i)/(2.5e-6)))); % this is a phase grating grating!
% %         if x(i)^2 + y(j)^2 <=(1e-6)^2
% %             U(i,j)=1.0; % this is an offset top-hat!
% %         end
%     end
% end

% propagate U - this section "runs" Goodman Fourier Optics eqn. 4-17
%U_prop=U.*exp(0.5*1i*(k/z)*x_square); % alternative form, not used here
U_prop=U.*exp(0.5*1i*(k/z).*(X.*X+Y.*Y)); % multiply U by the phase factor inside the curly brackets
U_out=fft2(U_prop); % fourier transform
U_out=ifftshift(U_out); % re-centre result of fourier transform
U_out_phase=U_out.*exp(0.5*1i*(k/z).*(X_out.*X_out+Y_out.*Y_out)); % multiply by the phase factor infront of the integral
% note, this last term has NOT been checked....
% also note, it doesn't do the (e^jkz)/(j*lambda*z) term (but that doesn't normally matter)....

% get intensity of output for plotting...
intensity=abs(U_out_phase.*U_out_phase); % intensity calc.

% plot
surf(x,y,angle(U),'linestyle','none'); % plot "input U" vs. "input position"
figure
surf(x_out,y_out,intensity,'linestyle','none'); % plot "output intensity" vs. "output position"
