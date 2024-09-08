clc; clear; close all;

% Parameters
Vm = 100;               % Peak AC voltage (in volts)
f = 50;                 % Frequency of AC supply (in Hz)
R = 50;                 % Resistance (in ohms)
L = 200e-3;             % Inductance (in henrys)
C = 100e-6;             % Capacitance (in farads)
t = linspace(0, 0.1, 1000); % Time vector (in seconds)
dt = t(2) - t(1);       % Time step

% Input AC voltage (sinusoidal waveform)
V_in = Vm * sin(2 * pi * f * t);

% Full-Wave Rectified Output Voltage (Absolute value of input)
V_rectified = abs(V_in);

% Initialize current arrays for each branch (R, L, C)
I_R = zeros(size(t));  % Current through the resistor
I_L = zeros(size(t));  % Current through the inductor
I_C = zeros(size(t));  % Current through the capacitor
V_L = zeros(size(t));  % Voltage across the inductor

% Simulate the currents through each branch
for i = 2:length(t)
    % Current through the resistor (Ohm's law)
    I_R(i) = V_rectified(i) / R;
    
    % Inductor differential equation: V = L * (di/dt)
    di_L = (V_rectified(i) - V_L(i-1)) * dt / L; % Change in current
    I_L(i) = I_L(i-1) + di_L;                    % Current through the inductor
    V_L(i) = L * (I_L(i) - I_L(i-1)) / dt;       % Voltage across inductor
    
    % Capacitor differential equation: I = C * (dV/dt)
    dV_C = (V_rectified(i) - V_rectified(i-1)) / dt;
    I_C(i) = C * dV_C;                           % Current through the capacitor
end

% Total current through the load (sum of branch currents)
I_total = I_R + I_L + I_C;

% Plotting the input voltage, rectified voltage, and branch currents
figure;

% Input AC voltage plot
subplot(4,1,1);
plot(t, V_in, 'b', 'LineWidth', 1.5);
title('Input AC Voltage');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Full-wave rectified voltage plot
subplot(4,1,2);
plot(t, V_rectified, 'r', 'LineWidth', 1.5);
title('Full-Wave Rectified Voltage');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Current through each branch (R, L, C)
subplot(4,1,3);
plot(t, I_R, 'g', 'LineWidth', 1.5); hold on;
plot(t, I_L, 'm', 'LineWidth', 1.5); hold on;
plot(t, I_C, 'c', 'LineWidth', 1.5);
title('Currents through Resistor (I_R), Inductor (I_L), and Capacitor (I_C)');
xlabel('Time (s)');
ylabel('Current (A)');
legend('I_R', 'I_L', 'I_C');
grid on;

% Total current through the load plot
subplot(4,1,4);
plot(t, I_total, 'k', 'LineWidth', 1.5);
title('Total Current through RLC Load');
xlabel('Time (s)');
ylabel('Current (A)');
grid on;

% Display average DC total current
I_dc_avg = mean(I_total);
disp(['Average DC Total Load Current (Idc): ', num2str(I_dc_avg), ' A']);
