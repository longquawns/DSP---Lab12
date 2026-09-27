
// Clear previous workspace, console, and graphics
clear;
clc;
scf(0);
clf();

// ------------------------------------------------------------
// 1. Signal parameters
// ------------------------------------------------------------
A = 3;                      // Amplitude
wa = 100 * %pi;             // Analog angular frequency (rad/s)
f = wa / (2 * %pi);         // Analog frequency: 50 Hz
T = 1 / f;                  // Analog period: 0.02 s

Fs = 300;                   // Sampling frequency (samples/s)
Ts = 1 / Fs;                // Sampling period (s)
Delta = 0.1;                // Quantization step

number_of_periods = 5;

// ------------------------------------------------------------
// 2. Analog signal xa(t): draw exactly 5 periods
// ------------------------------------------------------------
t_end = number_of_periods * T;  // 0.1 s
dt_plot = T / 200;              // For smooth graphical display only

t = 0:dt_plot:t_end;
xa = A * sin(wa * t);

// ------------------------------------------------------------
// 3. Sampled discrete-time signal x[n]
// ------------------------------------------------------------
// x[n] = xa(nTs) = 3*sin((pi/3)*n)
// Fundamental discrete-time period N0 = 6 samples.
N0 = 6;
n = 0:(number_of_periods * N0 - 1);  // n = 0, 1, ..., 29

xn = A * sin(wa * n * Ts);

// ------------------------------------------------------------
// 4. Quantization using the truncated/floor convention
// ------------------------------------------------------------
// xq[n] = Delta * floor(x[n] / Delta)
xq = Delta * floor(xn / Delta);

// In theory, x[n] = 0 at n = 0, 3, 6, ... .
// Floating-point arithmetic can represent these values as a very
// small negative number, which floor() would incorrectly map to -0.1.
// The following line corrects only that numerical representation error.
zero_tolerance = 100 * %eps * max(abs(xn));
xq(abs(xn) < zero_tolerance) = 0;

// ------------------------------------------------------------
// 5. Draw xa(t), x[n], and xq[n] in one graphics window
// ------------------------------------------------------------

// ----- Subplot 1: Analog signal -----
subplot(3, 1, 1);
plot(t, xa, "b-");

a1 = gca();
a1.data_bounds = [0, -3.5; t_end, 3.5];
a1.x_location = "origin";

xtitle( ...
    "Analog signal: x_a(t) = 3 sin(100 pi t)", ...
    "Time t (s)", ...
    "Amplitude");

// ----- Subplot 2: Sampled discrete-time signal -----
subplot(3, 1, 2);
plot2d3(n, xn);        // Stem-like vertical lines
plot(n, xn, "ro");    // Red sample markers

a2 = gca();
a2.data_bounds = [0, -3.5; 30, 3.5];
a2.x_location = "origin";

xtitle( ...
    "Discrete-time signal: x[n], F_s = 300 Hz", ...
    "Sample index n", ...
    "Amplitude");

// ----- Subplot 3: Quantized discrete-time signal -----
subplot(3, 1, 3);
plot2d3(n, xq);        // Stem-like vertical lines
plot(n, xq, "bo");    // Blue quantized-sample markers

a3 = gca();
a3.data_bounds = [0, -3.5; 30, 3.5];
a3.x_location = "origin";

xtitle( ...
    "Quantized signal: x_q[n], Delta = 0.1", ...
    "Sample index n", ...
    "Amplitude");

// ------------------------------------------------------------
// 6. Print theoretical results in the Scilab console
// ------------------------------------------------------------
mprintf("f = %.6f Hz\n", f);
mprintf("T = %.6f s\n", T);
mprintf("Fs = %.6f samples/s\n", Fs);
mprintf("Ts = %.12f s\n", Ts);
mprintf("Discrete-time angular frequency = pi/3 rad/sample\n");
mprintf("Normalized frequency = 1/6 cycle/sample\n");
mprintf("Fundamental period N0 = %d samples\n", N0);

mprintf("\nOne period of x[n] and xq[n]:\n");
mprintf("n\t x[n]\t\t xq[n]\n");

for k = 1:N0
    mprintf("%d\t %.12f\t %.1f\n", n(k), xn(k), xq(k));
end
