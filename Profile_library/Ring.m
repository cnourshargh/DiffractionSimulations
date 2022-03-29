n = 2^10;
x = linspace(-n/2,n/2,n);
y = x;
[X,Y] = meshgrid(x,y);
M = ones(n);
p = -0.1;

A = (X.^2+Y.^2<=9^2); 
M(A) = exp(1i*pi);

B = (X.^2+Y.^2>=10^2); 
M(B) = exp(1i*p*pi);

B = (X.^2+Y.^2>=19^2); 
M(B) = exp(1i*pi);

B = (X.^2+Y.^2>=22.5^2); 
M(B) = 0;