clear all;close all;clc;
%=======================================================
% Wnr calcuting
%=======================================================
for r = 0:3 
    Wnr_factor  = cos(pi/4*r) - j*sin(pi/4*r) ;
    Wnr_integer = floor(Wnr_factor * 2^13) ;
    
    if (real(Wnr_integer)<0) 
        Wnr_real    = real(Wnr_integer) + 2^16 ;
    else
        Wnr_real    = real(Wnr_integer) ;
    end
    if (imag(Wnr_integer)<0) 
        Wnr_imag    = imag(Wnr_integer) + 2^16 ; 
    else
        Wnr_imag    = imag(Wnr_integer);
    end
    
    Wnr(2*r+1,:)  =  dec2hex(Wnr_real) 
    Wnr(2*r+2,:)  =  dec2hex(Wnr_imag)
end



