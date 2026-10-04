// =====================================================================
// DSP Lab 2 - Additional Exercises 1.7, 1.9, and 1.10
// =====================================================================

clear;
clc;
format("v", 16);

// ---------------------------------------------------------------------
// Exercise 1.7 - Sampling and aliasing
// An analog signal contains frequency components up to 10 kHz.
// ---------------------------------------------------------------------
B_17 = 10000;               // highest analog frequency, Hz
Fs_min_17 = 2 * B_17;       // Nyquist sampling rate, samples/s
Fs_17 = 8000;               // sampling rate specified in parts (b), (c)

F1 = 5000;                  // component for part (b), Hz
F2 = 9000;                  // component for part (c), Hz

// Map normalized frequencies to the principal interval [-0.5, 0.5).
// For these specified values, subtracting one sampling-rate interval is exact;
// no numerical rounding operation is used.
f1_normalized = F1 / Fs_17;
f2_normalized = F2 / Fs_17;
f1_alias_normalized = f1_normalized - 1;
f2_alias_normalized = f2_normalized - 1;

F1_alias = abs(f1_alias_normalized) * Fs_17;
F2_alias = abs(f2_alias_normalized) * Fs_17;

// A cosine is used only to illustrate that the sample values coincide.
// The alias sign affects phase for a sine, but not the alias magnitude.
n_17 = 0:15;
x_5k = cos(2 * %pi * f1_normalized * n_17);
x_3k_alias = cos(2 * %pi * (F1_alias / Fs_17) * n_17);
x_9k = cos(2 * %pi * f2_normalized * n_17);
x_1k_alias = cos(2 * %pi * (F2_alias / Fs_17) * n_17);

scf(1);
clf();

subplot(4, 1, 1);
plot2d3(n_17, x_5k, 2);
a = gca();
a.x_location = "origin";
a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Exercise 1.7: 5 kHz component sampled at Fs = 8 kHz", "Sample index n", "Amplitude");

subplot(4, 1, 2);
plot2d3(n_17, x_3k_alias, 5);
a = gca();
a.x_location = "origin";
a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Equivalent discrete-time sequence: 3 kHz alias", "Sample index n", "Amplitude");

subplot(4, 1, 3);
plot2d3(n_17, x_9k, 2);
a = gca();
a.x_location = "origin";
a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Exercise 1.7: 9 kHz component sampled at Fs = 8 kHz", "Sample index n", "Amplitude");

subplot(4, 1, 4);
plot2d3(n_17, x_1k_alias, 13);
a = gca();
a.x_location = "origin";
a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Equivalent discrete-time sequence: 1 kHz alias", "Sample index n", "Amplitude");

// ---------------------------------------------------------------------
// Exercise 1.9 - ECG sampling rate
// The input waveform is unspecified, so the plot is a frequency-support
// indicator, not an amplitude spectrum.
// ---------------------------------------------------------------------
B_19 = 100;                 // useful ECG frequencies extend to 100 Hz
nyquist_rate_19 = 2 * B_19;
Fs_19 = 250;
unique_frequency_limit_19 = Fs_19 / 2;

f_axis_19 = 0:0.25:unique_frequency_limit_19;
support_indicator_19 = zeros(f_axis_19);
support_indicator_19(find(f_axis_19 <= B_19)) = 1;

scf(2);
clf();
plot(f_axis_19, support_indicator_19, "b-");
a = gca();
a.x_location = "origin";
a.data_bounds = [0, -0.1; unique_frequency_limit_19, 1.2];
xgrid(1);
xtitle("Exercise 1.9: Useful ECG band and unique-frequency limit", ...
       "Frequency (Hz)", "Support indicator");

// ---------------------------------------------------------------------
// Exercise 1.10 - Sampling two analog sinusoids at Fs = 600 Hz
// xa(t) = sin(480*pi*t) + 3*sin(720*pi*t)
// ---------------------------------------------------------------------
Fs_110 = 600;
Ts_110 = 1 / Fs_110;

F_low = 480 * %pi / (2 * %pi);     // 240 Hz
F_high = 720 * %pi / (2 * %pi);    // 360 Hz
nyquist_rate_110 = 2 * max(F_low, F_high);
folding_frequency_110 = Fs_110 / 2;

omega_low = 2 * %pi * F_low / Fs_110;    // 4*pi/5 rad/sample
omega_high = 2 * %pi * F_high / Fs_110;  // 6*pi/5 rad/sample
omega_high_principal = omega_high - 2 * %pi; // -4*pi/5 rad/sample

n_110 = 0:19;
x_n = sin(omega_low * n_110) + 3 * sin(omega_high * n_110);
x_n_equivalent = -2 * sin((4 * %pi / 5) * n_110);

// Continuous-time signals for visual comparison only.
t_110 = 0:1e-5:(19 * Ts_110);
xa_t = sin(480 * %pi * t_110) + 3 * sin(720 * %pi * t_110);
ya_t = -2 * sin(480 * %pi * t_110);

scf(3);
clf();

subplot(3, 1, 1);
plot(t_110, xa_t, "b-");
a = gca();
a.x_location = "origin";
a.data_bounds = [0, -4.5; 19 * Ts_110, 4.5];
xgrid(1);
xtitle("Exercise 1.10: Original analog signal xa(t)", "Time t (s)", "Amplitude");

subplot(3, 1, 2);
plot2d3(n_110, x_n, 5);
a = gca();
a.x_location = "origin";
a.data_bounds = [-1, -2.5; 20, 2.5];
xgrid(1);
xtitle("Sampled sequence x[n] = -2 sin(4*pi*n/5)", "Sample index n", "Amplitude");

subplot(3, 1, 3);
plot(t_110, ya_t, "r-");
a = gca();
a.x_location = "origin";
a.data_bounds = [0, -2.5; 19 * Ts_110, 2.5];
xgrid(1);
xtitle("Ideal D/A reconstruction ya(t) = -2 sin(480*pi*t)", "Time t (s)", "Amplitude");

// ---------------------------------------------------------------------
// Numerical verification printed in the Scilab console
// ---------------------------------------------------------------------
disp("EXERCISE 1.7");
disp("Minimum sampling rate for exact reconstruction (Hz):");
disp(Fs_min_17);
disp("5 kHz aliases to magnitude (Hz) at Fs = 8 kHz:");
disp(F1_alias);
disp("9 kHz aliases to magnitude (Hz) at Fs = 8 kHz:");
disp(F2_alias);
disp("Maximum absolute difference: 5 kHz and 3 kHz sample sequences:");
disp(max(abs(x_5k - x_3k_alias)));
disp("Maximum absolute difference: 9 kHz and 1 kHz sample sequences:");
disp(max(abs(x_9k - x_1k_alias)));

disp("EXERCISE 1.9");
disp("Nyquist rate for the ECG signal (samples/s):");
disp(nyquist_rate_19);
disp("Highest uniquely representable frequency at 250 samples/s (Hz):");
disp(unique_frequency_limit_19);

disp("EXERCISE 1.10");
disp("Nyquist sampling rate (samples/s):");
disp(nyquist_rate_110);
disp("Folding frequency (Hz):");
disp(folding_frequency_110);
disp("Discrete-time frequencies before principal-interval mapping (rad/sample):");
disp([omega_low, omega_high]);
disp("Principal discrete-time frequencies (rad/sample):");
disp([omega_low, omega_high_principal]);
disp("Maximum absolute difference between direct and simplified x[n]:");
disp(max(abs(x_n - x_n_equivalent)));
