% fourier propagation method test (based on Goodman Fourier Optics eqn. 4-17)

% define some general things
lambda=500e-09; % wavelength of light in metres
k=2*pi/lambda; % wavenumber of light
unit=0.5e-06; % step size of input array in metres

% define some specific values
z=200.0e-03; % propagation distance in metres
n=2000; % no of steps in input array (physical total input width with be = n*unit)
x = linspace(-0.5*unit*n,0.5*unit*n,n); % represents position across input array
%x_square=x.*x; % element by element square of the above - not used here

% create output length scale and array from delta_x_out = (z*lambda)/(n*delta_x_in)
unit_out=(z*lambda)/(n*unit); % step size of output array in metres
x_out = linspace(-0.5*unit_out*n,0.5*unit_out*n,n); % represents position across output array
% note: total width of output array space = (z*lambda)/delta_x_in

% setp up an input field "U" (this can be anything we want....)
U=zeros(1,n);
for i=900:1000 % goes up to 1000 here, so fills half the input space
%    U(i)=0.5*(1+cos(x(i)/(2.5e-6))); % this is an amplitude grating!
    U(i)=1.0; % this is an offset top-hat!
end

% propagate U - this section "runs" Goodman Fourier Optics eqn. 4-17
%U_prop=U.*exp(0.5*1i*(k/z)*x_square); % alternative form, not used here
U_prop=U.*exp(0.5*1i*(k/z).*x.*x); % multiply U by the phase factor inside the curly brackets
U_out=fft(U_prop); % fourier transform
U_out=fftshift(U_out); % re-centre result of fourier transform
U_out_phase=U_out.*exp(0.5*1i*(k/z).*x_out.*x_out); % multiply by the phase factor infront of the integral
% note, this last term has NOT been checked....
% also note, it doesn't do the (e^jkz)/(j*lambda*z) term (but that doesn't normally matter)....

% get intensity of output for plotting...
intensity=abs(U_out_phase.*U_out_phase); % intensity calc.

% plot
plot(x,U); % plot "input U" vs. "input position"
figure
plot(x_out,intensity); % plot "output intensity" vs. "output position"
