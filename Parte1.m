datos = readtable("data_motor.csv");
columna2 = datos.time_t_;
columna3 = datos.ex_signal_u_;
columna4 = datos.system_response_y_;

plot(columna2, columna3, 'b-', 'LineWidth', 1.5, 'DisplayName', 'ex signal u'); % Línea roja continua
hold on;
plot(columna2, columna4, 'r-', 'LineWidth', 1.5, 'DisplayName', 'system response y'); % Línea azul continua
hold off;

xlabel('time_t');
ylabel('Valores');
title('Gráfica con los conjuntos de datos');
legend; 
grid on; 