n = 2^10;
x = linspace(-n/2,n/2,n);
y = x;
[X,Y] = meshgrid(x,y);
M = zeros(n);
p = 2;
for i = 1:n
    for j = 1:n
       M(i,j) = p*atan2(X(i,j),Y(i,j));
    end
end

B = (X.^2+Y.^2>=2^9); 
M(B) = M(B)+pi*p*24;

B = (X.^2+Y.^2>=2^7); 
M(B) = M(B)+pi*p*24;

M = PhaseProfile2IncidentBeam(M);
% M2 = PhaseProfile2IncidentBeam(M2);
theta = atan2(X,Y);

% A =  theta=pi2; 
% M(A) = exp(1ipi);
% 
% A =  theta=pi6; 
% M(A) = exp(1i0);

% B = (X.^2+Y.^2=17^2) & (X.^2+Y.^2=20^2); 
% M(B) = exp(1ippi);

% B = (X.^2+Y.^2=20^2);
% M(B) = exp(pip1i);

B = (X.^2+Y.^2>=2^11); 
M(B) = 1;

B = (X.^2+Y.^2>=2^13); 
M(B) = 0;
%M2(B) = 0;