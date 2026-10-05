// =====================================================================
// DSP Lab 2 -- Additional Exercises 1.7, 1.9, and 1.10
// =====================================================================

clear;
clc;
format("v", 16);

// ---------------------------------------------------------------------
// Exercise 1.7 -- Sampling and aliasing
// ---------------------------------------------------------------------
// The signal contains frequencies up to 10 kHz.  At Fs = 8 kHz,
// F1 = 5 kHz aliases to -3 kHz and F2 = 9 kHz aliases to +1 kHz.

B_17 = 10000;                 // Hz
Fs_17 = 8000;                 // Hz
F1_17 = 5000;                 // Hz
F2_17 = 9000;                 // Hz
Fs_min_17 = 2 * B_17;         // Nyquist sampling rate

F1_alias_17 = F1_17 - Fs_17;  // -3000 Hz
F2_alias_17 = F2_17 - Fs_17;  // +1000 Hz

n_17 = 0:15;
x_5k = cos(2 * %pi * F1_17 * n_17 / Fs_17);
x_3k_alias = cos(2 * %pi * F1_alias_17 * n_17 / Fs_17);
x_9k = cos(2 * %pi * F2_17 * n_17 / Fs_17);
x_1k_alias = cos(2 * %pi * F2_alias_17 * n_17 / Fs_17);

scf(1); clf();
subplot(4, 1, 1);
plot2d3(n_17, x_5k, 2);
a = gca(); a.x_location = "origin"; a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Exercise 1.7: 5 kHz sampled at Fs = 8 kHz", "Sample index n", "Amplitude");

subplot(4, 1, 2);
plot2d3(n_17, x_3k_alias, 5);
a = gca(); a.x_location = "origin"; a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Equivalent sequence: -3 kHz alias", "Sample index n", "Amplitude");

subplot(4, 1, 3);
plot2d3(n_17, x_9k, 2);
a = gca(); a.x_location = "origin"; a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Exercise 1.7: 9 kHz sampled at Fs = 8 kHz", "Sample index n", "Amplitude");

subplot(4, 1, 4);
plot2d3(n_17, x_1k_alias, 13);
a = gca(); a.x_location = "origin"; a.data_bounds = [-1, -1.2; 16, 1.2];
xgrid(1);
xtitle("Equivalent sequence: +1 kHz alias", "Sample index n", "Amplitude");

// ---------------------------------------------------------------------
// Exercise 1.9 -- Sampling and reconstruction of a two-tone signal
// xa(t) = sin(480*pi*t) + 3*sin(720*pi*t), sampled at Fs = 600 Hz.
// ---------------------------------------------------------------------

Fs_19 = 600;                  // samples/s
Ts_19 = 1 / Fs_19;
F1_19 = 240;                  // Hz
F2_19 = 360;                  // Hz
Fs_nyquist_19 = 2 * F2_19;    // 720 samples/s
Ffold_19 = Fs_19 / 2;         // 300 Hz

omega1_19 = 2 * %pi * F1_19 / Fs_19;   // 4*pi/5
omega2_19 = 2 * %pi * F2_19 / Fs_19;   // 6*pi/5
omega2p_19 = omega2_19 - 2 * %pi;       // -4*pi/5

n_19 = 0:19;
x_direct_19 = sin(omega1_19 * n_19) + 3 * sin(omega2_19 * n_19);
x_equiv_19 = -2 * sin(4 * %pi * n_19 / 5);

t_19 = 0:1e-5:(n_19($) * Ts_19);
xa_19 = sin(480 * %pi * t_19) + 3 * sin(720 * %pi * t_19);
ya_19 = -2 * sin(480 * %pi * t_19);

scf(2); clf();
subplot(3, 1, 1);
plot(t_19, xa_19, "b-");
a = gca(); a.x_location = "origin"; a.data_bounds = [0, -4.5; n_19($) * Ts_19, 4.5];
xgrid(1);
xtitle("Exercise 1.9: Original analog signal xa(t)", "Time t (s)", "Amplitude");

subplot(3, 1, 2);
plot2d3(n_19, x_direct_19, 5);
a = gca(); a.x_location = "origin"; a.data_bounds = [-1, -2.5; 20, 2.5];
xgrid(1);
xtitle("Sampled sequence x[n] = -2 sin(4*pi*n/5)", "Sample index n", "Amplitude");

subplot(3, 1, 3);
plot(t_19, ya_19, "r-");
a = gca(); a.x_location = "origin"; a.data_bounds = [0, -2.5; n_19($) * Ts_19, 2.5];
xgrid(1);
xtitle("Ideal D/A reconstruction ya(t) = -2 sin(480*pi*t)", "Time t (s)", "Amplitude");

// ---------------------------------------------------------------------
// Exercise 1.10 -- Bit rate, sampling frequency, and quantization
// xa(t) = 3cos(600*pi*t) + 2cos(1800*pi*t).
// Rb = 10000 bits/s and L = 1024 quantization levels.
// ---------------------------------------------------------------------

Rb_110 = 10000;               // bits/s
L_110 = 1024;                 // levels
b_110 = log(L_110) / log(2);  // bits/sample = 10
Fs_110 = Rb_110 / b_110;      // 1000 samples/s
Ffold_110 = Fs_110 / 2;       // 500 Hz

F1_110 = 300;                 // 600*pi / (2*pi), Hz
F2_110 = 900;                 // 1800*pi / (2*pi), Hz
Fs_nyquist_110 = 2 * F2_110;  // 1800 samples/s

omega1_110 = 2 * %pi * F1_110 / Fs_110;   // 3*pi/5
omega2_110 = 2 * %pi * F2_110 / Fs_110;   // 9*pi/5
omega2p_110 = omega2_110 - 2 * %pi;        // -pi/5

xmin_110 = -5;
xmax_110 = 5;
Delta_110 = (xmax_110 - xmin_110) / (L_110 - 1);

n_110 = 0:29;
x_direct_110 = 3 * cos(omega1_110 * n_110) + 2 * cos(omega2_110 * n_110);
x_equiv_110 = 3 * cos(3 * %pi * n_110 / 5) + 2 * cos(%pi * n_110 / 5);

scf(3); clf();
subplot(2, 1, 1);
plot2d3(n_110, x_direct_110, 2);
a = gca(); a.x_location = "origin"; a.data_bounds = [-1, -5.5; 30, 5.5];
xgrid(1);
xtitle("Exercise 1.10: Direct sampled sequence x[n]", "Sample index n", "Amplitude");

subplot(2, 1, 2);
plot2d3(n_110, x_equiv_110, 5);
a = gca(); a.x_location = "origin"; a.data_bounds = [-1, -5.5; 30, 5.5];
xgrid(1);
xtitle("Equivalent sequence after aliasing", "Sample index n", "Amplitude");

// ---------------------------------------------------------------------
// Numerical verification in the Scilab console
// ---------------------------------------------------------------------

mprintf("\nEXERCISE 1.7\n");
mprintf("Minimum sampling rate: %.0f samples/s\n", Fs_min_17);
mprintf("5 kHz alias: %.0f Hz\n", F1_alias_17);
mprintf("9 kHz alias: %.0f Hz\n", F2_alias_17);
mprintf("Maximum error, 5 kHz and -3 kHz sequences: %.3e\n", max(abs(x_5k - x_3k_alias)));
mprintf("Maximum error, 9 kHz and +1 kHz sequences: %.3e\n", max(abs(x_9k - x_1k_alias)));

mprintf("\nEXERCISE 1.9\n");
mprintf("Nyquist sampling rate: %.0f samples/s\n", Fs_nyquist_19);
mprintf("Folding frequency: %.0f Hz\n", Ffold_19);
mprintf("Discrete-time frequencies: omega1 = %.6f, omega2 = %.6f rad/sample\n", omega1_19, omega2p_19);
mprintf("Maximum error, direct and simplified x[n]: %.3e\n", max(abs(x_direct_19 - x_equiv_19)));

mprintf("\nEXERCISE 1.10\n");
mprintf("Bits/sample: %.0f\n", b_110);
mprintf("Sampling frequency: %.0f samples/s\n", Fs_110);
mprintf("Folding frequency: %.0f Hz\n", Ffold_110);
mprintf("Nyquist sampling rate: %.0f samples/s\n", Fs_nyquist_110);
mprintf("Discrete-time frequencies: omega1 = %.6f, omega2 = %.6f rad/sample\n", omega1_110, omega2p_110);
mprintf("Resolution Delta: %.10f\n", Delta_110);
mprintf("Maximum error, direct and equivalent x[n]: %.3e\n", max(abs(x_direct_110 - x_equiv_110)));