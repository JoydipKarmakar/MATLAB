clc; clear; close all;

% Parameters
Vm = 10;                 % Peak AC voltage (in volts)
f = 50;                  % Frequency of AC supply (in Hz)
R = 10;                  % Resistance (in ohms)
L = 50e-3;               % Inductance (in henrys)
C = 100e-6;              % Capacitance (in farads)
t = linspace(0, 0.1, 1000); % Time vector (in seconds)
dt = t(2) - t(1);        % Time step for numerical integration

% Input AC voltage (sinusoidal waveform)
V_in = Vm * sin(2 * pi * f * t);

% Full-Wave Rectified Output Voltage (Absolute value of input)
V_rectified = abs(V_in);

% Initialize arrays for current, voltage, and capacitor voltage
I_load = zeros(size(t));  % Current through the RLC load
V_out = zeros(size(t));   % Voltage across the load (after the rectifier)
V_cap = zeros(size(t));   % Voltage across the capacitor

% Simulation of the RLC circuit using numerical integration
for i = 2:length(t)
    % Inductor differential equation: V - I*R - V_cap = L * (di/dt)
    di = (V_rectified(i) - I_load(i-1)*R - V_cap(i-1)) * dt / L;  % Change in current
    I_load(i) = I_load(i-1) + di;  % Update current through RLC load

    % Voltage across the capacitor (integral of current)
    dV_cap = (I_load(i) / C) * dt;  % Change in capacitor voltage
    V_cap(i) = V_cap(i-1) + dV_cap; % Update capacitor voltage

    % Output voltage across the load (current through the resistor)
    V_out(i) = I_load(i) * R;
end

% Plotting the input AC voltage, rectified voltage, and output voltage
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
title('Full-Wave Rectified Voltage (Before Filtering)');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Voltage across the capacitor plot
subplot(4,1,3);
plot(t, V_cap, 'g', 'LineWidth', 1.5);
title('Voltage Across the Capacitor');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Output voltage across the load plot
subplot(4,1,4);
plot(t, V_out, 'm', 'LineWidth', 1.5);
title('Filtered Output Voltage Across Load (After RLC)');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Displaying average DC output voltage and ripple
V_dc_avg = mean(V_out);
V_ripple = max(V_out) - min(V_out);

disp(['Average DC Output Voltage (Vdc): ', num2str(V_dc_avg), ' V']);
disp(['Ripple Voltage (Vripple): ', num2str(V_ripple), ' V']);
