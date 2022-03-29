n = 2^10;
x = linspace(-n/2,n/2,n);
y = x;
[X,Y] = meshgrid(x,y);
M = zeros(n);
p = 3;
for i = 1:n
    for j = 1:n
       M(i,j) = p*atan2(X(i,j),Y(i,j));
    end
end
M = PhaseProfile2IncidentBeam(M);

theta = atan2(X,Y);


A =  abs(theta)<=2*pi/3; 
M(A) = exp(1i*pi);

% B = (X.^2+Y.^2>=17^2) & (X.^2+Y.^2<=20^2); 
% M(B) = exp(1i*p*pi);

% B = (X.^2+Y.^2>=20^2);
% M(B) = 1;

B = (X.^2+Y.^2>=22.5^2); 
M(B) = 0;