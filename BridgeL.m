clc; clear; close all;

% Parameters
Vm = 10;                % Peak AC voltage (in volts)
f = 50;                 % Frequency of AC supply (in Hz)
R = 10;                 % Load resistance (in ohms)
L = 50e-3;              % Inductance value (in henrys)
t = linspace(0, 0.1, 1000); % Time vector (in seconds)
dt = t(2) - t(1);       % Time step for numerical integration

% Input AC voltage (sinusoidal waveform)
V_in = Vm * sin(2 * pi * f * t);

% Full-Wave Rectified Output Voltage (Absolute value of input)
V_rectified = abs(V_in);

% Initialize current and output voltage arrays
I_load = zeros(size(t));  % Current through the inductor (initially zero)
V_out = zeros(size(t));   % Voltage across the load

% Simulate the inductor's effect on the current
for i = 2:length(t)
    % Inductor differential equation: V = L * (di/dt) + i * R
    di = (V_rectified(i) - I_load(i-1) * R) * dt / L; % Change in current
    I_load(i) = I_load(i-1) + di;  % Current through the inductor
    V_out(i) = I_load(i) * R;      % Voltage across the load (Ohm's law)
end

% Plotting the input AC voltage, rectified voltage, and current through load
figure;

% Input AC voltage plot
subplot(3,1,1);
plot(t, V_in, 'b', 'LineWidth', 1.5);
title('Input AC Voltage');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Full-wave rectified voltage plot
subplot(3,1,2);
plot(t, V_rectified, 'r', 'LineWidth', 1.5);
title('Full-Wave Rectified Voltage (Before Inductor)');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Current through the inductor plot
subplot(3,1,3);
plot(t, I_load, 'g', 'LineWidth', 1.5);
title('Current Through Inductive Load');
xlabel('Time (s)');
ylabel('Current (A)');
grid on;

% Displaying average DC load current and output voltage
I_dc_avg = mean(I_load);
V_dc_avg = mean(V_out);

disp(['Average DC Load Current (Idc): ', num2str(I_dc_avg), ' A']);
disp(['Average DC Output Voltage (Vdc): ', num2str(V_dc_avg), ' V']);
