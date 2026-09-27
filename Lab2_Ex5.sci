// Define time vector matching the signal's origin at n = 0
n = -1:1;

// Define original signal x(n) = {1, 3 (origin), -2}
x = [1, 3, -2];

// Folded signal x(-n) over the same time range
x_folded = flipdim(x, 2); 

// Even component xe(n) = 0.5 * [x(n) + x(-n)]
xe = 0.5 * (x + x_folded);

// Odd component xo(n) = 0.5 * [x(n) - x(-n)]
xo = 0.5 * (x - x_folded);

// --- Plotting in a Single Window using Subplots ---
clf(); // Clear graphics window

// 1. Original Signal x(n)
subplot(3, 1, 1);
plot2d3(n, x, style=2);
gca().data_bounds = [-1.5, -3; 1.5, 4]; // [xmin, ymin; xmax, ymax]
title("Original Signal x(n)");
xlabel("Time index (n)");
ylabel("Amplitude");

// 2. Even Component xe(n)
subplot(3, 1, 2);
plot2d3(n, xe, style=2);
gca().data_bounds = [-1.5, -3; 1.5, 4];
title("Even Component x_e(n)");
xlabel("Time index (n)");
ylabel("Amplitude");

// 3. Odd Component xo(n)
subplot(3, 1, 3);
plot2d3(n, xo, style=2);
gca().data_bounds = [-1.5, -3; 1.5, 4];
title("Odd Component x_o(n)");
xlabel("Time index (n)");
ylabel("Amplitude");
