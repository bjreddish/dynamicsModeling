function mtf = MTF(theta,L,R)
%Modulated transformer function
mtf = R*sin(theta) -...
    ( (R^2 *cos(theta)*sin(theta))/(sqrt(L^2-R^2 * (sin(theta))^2)) );
end