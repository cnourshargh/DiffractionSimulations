function [output_field] = fresnel_diffraction(Incident_field,z,lambda,dx_incident)
%%Brute for force method for calculating fresnel diffraction. Implements
%%integral as 4 four loops. All ubits are metres. very inefficient

[sz ~] = size(Incident_field);

k_n = 2*pi/lambda;

E = zeros(sz);

dx_replay = z/(sz);
tic
for i = 1:sz
    for j = 1:sz
        for k = 1:sz
            for l = 1:sz
                E(i,j) = E(i,j) + Incident_field(k,l)*exp(1i*k_n/(2*z)*((k/dx_incident-i/dx_replay)^2+(l/dx_incident-j/dx_replay)^2));
            end
        end
    end
end
toc
output_field = abs(E).^2;
surf(output_field,linestyle= 'none');




