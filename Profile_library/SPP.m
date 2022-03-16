n = 2^10;
x = linspace(-n/2,n/2,n);
y = x;
[X,Y] = meshgrid(x,y);
M = ones(n);
for i = 1:n
    for j = 1:n
       % M(i,j) = atan2(X(i,j),Y(i,j));
    end
end
M = PhaseProfile2IncidentBeam(M);


A = (X.^2+Y.^2<=20^2); 
M(A) = exp(1i*pi/2);

B = (X.^2+Y.^2>=200^2); 
M(B) = 0;
