rango = (columna2 >= 1.5) & (columna2 <= 5);
linea_base = mean(columna4(rango));

x0 = 0.20202; % Punto conocido en el eje x donde comienza a crecer la azul
y0 = 0; % El valor de y en ese punto es 0

% Calcular la pendiente en ese punto
dy_dt = gradient(columna4, columna2); % Derivada numérica
m = interp1(columna2, dy_dt, x0); % Pendiente en x0

% Encontrar la intersección con la línea negra (y = 1)
x_intersect = (linea_base - y0) / m + x0; % Resolviendo la ecuación de la recta

% Generar puntos para la recta tangente
x_tangent = linspace(x0, x_intersect, 100);
y_tangent = m * (x_tangent - x0) + y0;


plot(columna2, columna3, 'b-', 'LineWidth', 1.5, 'DisplayName', 'ex signal u'); % Línea roja continua
hold on;
plot(columna2, columna4, 'r-', 'LineWidth', 1.5, 'DisplayName', 'system response y'); % Línea azul continua
hold on;
plot(x_tangent, y_tangent, 'g--', 'LineWidth', 2, 'DisplayName', 'recta tangente'); % Recta tangente en verde punteado
hold off;
yline(linea_base, 'k--', 'LineWidth', 1.5, 'DisplayName', 'linea base 100%');


xlabel('time_t');
ylabel('Valores');
title('Gráfica con los conjuntos de datos');
legend; 
grid on; 