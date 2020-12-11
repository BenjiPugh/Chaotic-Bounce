param.freq = 8;
param.height = 1/100;
param.amp = 1/200;

[T, M] = bouncer_2(param);
clf
hold on
plot(T, M(:, 1))
M(2)
plot(T, param.amp*sin(param.freq * 2*pi*T))