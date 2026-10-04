// Define time vector
n = -1:1;

// Define original signal x(n) = {1, 3 (origin), -2} at n = [-1, 0, 1]
x = [1, 3, -2];

// Folded signal x(-n): flip vector elements
x_folded = x($:-1:1);

// Calculate Even and Odd components
xe = 0.5 * (x + x_folded);
xo = 0.5 * (x - x_folded);

// --- Plotting in a Single Window using Subplots ---
clf(); // Clear graphics window

// 1. Original Signal x(n)
subplot(3, 1, 1);
plot2d3(n, x, style=2);
a1 = gca();
a1.data_bounds = [-1.5, -3; 1.5, 4]; // [xmin, ymin; xmax, ymax]
a1.x_location = "origin";
title("Original Signal x(n)");
xlabel("Time index (n)");
a1.x_label.position = [1.2, -0.8]; 
ylabel("Amplitude");

// 2. Even Component xe(n)
subplot(3, 1, 2);
plot2d3(n, xe, style=2);
a2 = gca();
a2.data_bounds = [-1.5, -3; 1.5, 4];
a2.x_location = "origin"; 
title("Even Component x_e(n)");
xlabel("Time index (n)");
a2.x_label.position = [1.2, -0.8];
ylabel("Amplitude");

// 3. Odd Component xo(n)
subplot(3, 1, 3);
plot2d3(n, xo, style=2);
a3 = gca();
a3.data_bounds = [-1.5, -3; 1.5, 4];
a3.x_location = "origin";
title("Odd Component x_o(n)");
xlabel("Time index (n)");
a3.x_label.position = [1.2, -0.8];
ylabel("Amplitude");
