function [T, M] = bouncer_2(param)


    g = 9.8;                    %m/s^2 Acceleration due to gravity
    w = param.freq * (2 * pi);    %rad/s Calculate angular speed

    options = odeset('Events', @event_func);


    init = [param.height, 0];
    t_span = [0, param.time];
    T = [0];
    M = [0, 0];
    
    %continuously bounce the ball while wi
    while T(end) < t_span(end)
        [T1, M1] = ode45(@rate_func, [T(end), t_span(end)], init, options);
        T = [T;T1];
        M = [M;M1];
        vPlate = param.amp * w * cos(T(end) * w);
        init = [M(end, 1), -M(end, 2) + vPlate];
    end

    function res = rate_func(~, W)
        vBall = W(2);

        aBall = - g;
        
        res = [vBall; aBall];
    end
    
    %Event Function for when the ball hits the table
    function [value, isterminal, direction] = event_func(t, X)
        posBall = X(1);
        posPlate = param.amp * sin(t * w);
        value = posBall - posPlate;
        isterminal = 1;
        direction = -1;
    end


end