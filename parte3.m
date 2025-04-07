% Datos experimentales
rango = (columna2 >= 1.5) & (columna2 <= 5);
linea_base = mean(columna4(rango));

% Calcular la pendiente en x0
x0 = 0.353535; % Punto donde comienza a crecer la azul
y0 = interp1(columna2, columna4, x0, 'linear'); % Asegurar que el punto está en la curva

% Calcular la pendiente usando diferencias finitas centradas
dx = diff(columna2); % Diferencias en x
dy = diff(columna4); % Diferencias en y
dydx = dy ./ dx; % Pendiente entre puntos adyacentes
m = interp1(columna2(1:end-1), dydx, x0, 'linear'); % Interpolar la pendiente en x0

% Encontrar la intersección con la línea base (y = linea_base)
x_intersect = (linea_base - y0) / m + x0; % Resolviendo la ecuación de la recta

% Generar puntos para la recta tangente extendida hasta la intersección
x_tangent = linspace(x0, x_intersect, 100);
y_tangent = m * (x_tangent - x0) + y0; % Ecuación de la recta

% Parámetros de los 3 métodos de identificación (ajustar según cálculo)
K1 = 0.987;  tau1 = 1.146465;   theta1 = 0.353535;  % Método Ziegler and Nichols
K2 = 0.987;  tau2 = 0.579682;   theta2 = 0.353535; % Método 2 Miller (0.93322-0.353535)
K3 = 0.987;  tau3 = 0.5523;    theta3 = 0.43457; % Método Analitico

% Definir los sistemas de transferencia para cada método
s = tf('s');
G1 = tf(K1, [tau1 1], 'InputDelay', theta1);
G2 = tf(K2, [tau2 1], 'InputDelay', theta2);
G3 = tf(K3, [tau3 1], 'InputDelay', theta3);

% Simulación con entrada escalón unitario
t_sim = linspace(0, 5, 500);
u = ones(size(t_sim));
y_sim1 = lsim(G1, u, t_sim);
y_sim2 = lsim(G2, u, t_sim);
y_sim3 = lsim(G3, u, t_sim);

% Graficar datos experimentales
figure;
plot(columna2, columna3, 'b-', 'LineWidth', 1.5, 'DisplayName', 'ex signal u');
hold on;
plot(columna2, columna4, 'r-', 'LineWidth', 1.5, 'DisplayName', 'system response y');
hold on;
plot(x_tangent, y_tangent, 'black--', 'LineWidth', 2, 'DisplayName', 'Recta tangente'); % Recta tangente en verde punteado
hold on
% Graficar los modelos FOTD
plot(t_sim, y_sim1, 'm-', 'LineWidth', 2, 'DisplayName', 'Ziegler & Nichols');
hold on
plot(t_sim, y_sim2, 'c-', 'LineWidth', 2, 'DisplayName', 'Miller');
hold on
plot(t_sim, y_sim3, 'y-', 'LineWidth', 2, 'DisplayName', 'Método Analitico');
hold off
% Línea base
yline(linea_base, 'k--', 'LineWidth', 1.5, 'DisplayName', 'línea base 100%');

% Configuración de la gráfica
xlabel('time_t');
ylabel('Valores');
title('Comparación de respuesta del sistema y modelos FOTD');
legend;
grid on;
hold off;
