function [cross_section] = Beam_evolution(M)
[n ~] = size(M);
l = 100;
cross_section = zeros(n,l);

for i = 1:l
    P = fresnel_diffraction_fft(M,1e-1*i,500e-9,1e-6);
    P = (P-min(min(abs(P))))./max(max(abs(P)));
    cross_section(:,i) = abs(P(n/2,:));
end

surf(cross_section, 'linestyle','none');
shading interp