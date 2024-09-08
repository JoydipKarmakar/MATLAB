clc; clear; close all;

% Parameters
Vm = 10;               % Peak AC voltage (in volts)
f = 50;                % Frequency of AC supply (in Hz)
R = 10;                % Load resistance (in ohms)
C = 100e-6;            % Capacitor value (in farads)
t = linspace(0, 0.1, 1000); % Time vector (in seconds)

% Input AC voltage (sinusoidal waveform)
V_in = Vm * sin(2 * pi * f * t);

% Full-Wave Rectified Output Voltage (Absolute value of input)
V_rectified = abs(V_in);

% Simulate the Capacitor Charging and Discharging
V_out = zeros(size(V_rectified)); % Initialize output voltage array
V_out(1) = V_rectified(1);        % Initial voltage across the capacitor

% Capacitor discharge and ripple voltage computation
for i = 2:length(t)
    if V_rectified(i) > V_out(i-1)  % Capacitor charges to peak voltage
        V_out(i) = V_rectified(i);
    else
        % Capacitor discharges through the load
        V_out(i) = V_out(i-1) * exp(-(t(i) - t(i-1)) / (R * C));
    end
end

% Current through the Load
I_load = V_out / R;

% Plotting the input AC voltage, rectified voltage, and filtered output voltage
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
title('Full-Wave Rectified Voltage (Before Filtering)');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Filtered output voltage plot (after capacitor)
subplot(3,1,3);
plot(t, V_out, 'g', 'LineWidth', 1.5);
title('Filtered Output Voltage (After Capacitor)');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% Displaying average DC output voltage and ripple
V_dc_avg = mean(V_out);
V_ripple = max(V_out) - min(V_out);

disp(['Average DC Output Voltage (Vdc): ', num2str(V_dc_avg), ' V']);
disp(['Ripple Voltage (Vripple): ', num2str(V_ripple), ' V']);
