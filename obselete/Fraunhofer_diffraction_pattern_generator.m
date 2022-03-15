function [farfield] = Fraunhofer_diffraction_pattern_generator(phase_profile,beam_diameter)

pupil_funtion = expm(1i*phase_profile);
figure;
surf(phase_profile,edgecolour='none');


bf = fspecial('Gaussian',size(pupil_funtion),beam_diameter/sqrt(2));
beam_function = bf/max(max(bf));
figure
imshow(beam_function);


ff = fft2(pupil_funtion.*beam_function);

farfield = fftshift(ff);
figure;
imshow(log(abs(farfield).^2));