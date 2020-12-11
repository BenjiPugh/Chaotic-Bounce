function [T, M] = bouncer(params)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% params is of form [initial height ball, frequency,
%                    amplitude]

g = 9.8;
w = params(2)./(2*pi);
viPlate = params(3)*w;

initial = [0, params(1), viPlate, -10];
t_span = [0 1];

[T, M] = ode45(@rate_func, t_span, initial);

    function res = rate_func(~, W)
        
        posPlate = W(1);
        posBall = W(2);
        vPlate = W(3);
        vBall = W(4);
        
        if ((vBall < 0) && (posBall < (posPlate + 0.01)))
            vNew = -vBall + vPlate;
        else
            vNew = vBall;
        end
        
        aBall = - g;
        
        aPlate = -(w.^2) * posPlate;
        
        res = [vPlate; vNew; aPlate; aBall];
        
    end
end

