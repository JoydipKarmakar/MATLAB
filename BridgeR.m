% MATLAB code to simulate single-phase full-wave rectifier with R load

clc; clear; close all;

% Parameters
Vm = 10;               % Peak AC voltage (in volts)
f = 50;                % Frequency of AC supply (in Hz)
R = 10;                % Load resistance (in ohms)
t = linspace(0, 0.1, 1000); % Time vector (in seconds)

% Input AC voltage (sinusoidal waveform)
V_in = Vm * sin(2 * pi * f * t);

% Full-Wave Rectified Output Voltage (Absolute value of input)
V_rectified = abs(V_in);

% Current through the Load (Ohm's law: V = IR)
I_load = V_rectified / R;

% Plotting the input AC voltage and rectified output voltage
figure;

% Input AC voltage plot
subplot(3,1,1);
plot(t, V_in, 'b', 'LineWidth', 1.5);
title('Input AC Voltage');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Rectified voltage plot
subplot(3,1,2);
plot(t, V_rectified, 'r', 'LineWidth', 1.5);
title('Full-Wave Rectified Output Voltage');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Current through the load plot
subplot(3,1,3);
plot(t, I_load, 'g', 'LineWidth', 1.5);
title('Current Through the Load (R)');
xlabel('Time (s)');
ylabel('Current (A)');
grid on;

% Displaying average DC output voltage and current
V_dc_avg = mean(V_rectified);
I_dc_avg = mean(I_load);

disp(['Average DC Output Voltage (Vdc): ', num2str(V_dc_avg), ' V']);
disp(['Average DC Load Current (Idc): ', num2str(I_dc_avg), ' A']);
