function [output_field] = fresnel_diffraction_fft(Incident_field,z,lambda,dx_incident)
%calculates diffraction pattern produced by beam with given phase and
%intensity profile and wavelength at position z away from the incident
%field
k = 2*pi/lambda;              %calculates wave number for lambda

[sz ~] = size(Incident_field);

width = sz*dx_incident;

dfx = 1./width;

x = ((1:sz)-sz/2)*dfx;
y = x;

[X,Y] = meshgrid(x,y);

P = exp(1i*k./(2*z).*(X.^2+Y.^2));

I = P.*Incident_field;

G = fftshift(fft2(ifftshift(I)));

%h = exp(1i*k*z).*exp(-1i*pi/(lambda*z)*(X.^2+Y.^2));

output_field = 1/(lambda*z*1i).*G.*P;


%output_field = fftshift(ifft2(ifftshift(G.*h)));


figure;
surf(abs(output_field),'linestyle','none');