% Determinar la línea base promedio en el rango definido
rango = (columna2 >= 1.5) & (columna2 <= 5);
linea_base = mean(columna4(rango));

% Punto donde inicia la tangente (retraso Theta)
x0 = 0.353535; 
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

% Graficar los datos
plot(columna2, columna3, 'b-', 'LineWidth', 1.5, 'DisplayName', 'ex signal u');
hold on;
plot(columna2, columna4, 'r-', 'LineWidth', 1.5, 'DisplayName', 'system response y');
plot(x_tangent, y_tangent, 'g--', 'LineWidth', 2, 'DisplayName', 'Recta tangente');

% Línea base (100%)
yline(linea_base, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Línea base 100%');

% Etiquetas y leyenda
xlabel('time_t');
ylabel('Valores');
title('Gráfica con los conjuntos de datos');
legend;
grid on;
hold off;
