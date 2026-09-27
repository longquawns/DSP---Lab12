clear; clc; clf();

// 1. Time index vector (Zero-padded range)
idx = -1:3;

// 2. Input sequences aligned to the new index
seqA = [0, 0, 1, 3, -2];
seqB = [0, 1, 2, 3, 0];

// 3. Mathematical superposition
out_sum = seqA + seqB;

// 4. Data structures for plotting iteration
sig_arrays = list(seqA, seqB, out_sum);
plot_titles = ["Signal x1(n)", "Signal x2(n)", "Signal y(n) = x1(n) + x2(n)"];
// Using darker color themes to differentiate from standard templates
txt_colors = ["darkblue", "darkred", "forestgreen"];
marker_styles = ["bs", "rs", "gs"]; // b: blue, r: red, g: green | s: square marker

for k = 1:3
    subplot(3, 1, k);
    curr_data = sig_arrays(k);
    
    // Plotting stems and square markers
    plot2d3(idx, curr_data);
    plot(idx, curr_data, marker_styles(k));
    
    title(plot_titles(k), "fontsize", 3); 
    xlabel("n"); 
    ylabel("Amplitude");
    
    // Axes customization
    ax = gca(); 
    ax.x_location = "origin"; 
    ax.data_bounds = [-1.5, -4; 3.5, 8]; 
    ax.grid = [1, 1]; 
    
    // FORCING Y-AXIS TO SHOW EVERY INTEGER STEP (..., -1, 0, 1, 2, 3, 4, ...)
    y_range = [-4:1:8]'; 
    ax.y_ticks = tlist(["ticks", "locations", "labels"], y_range, string(y_range));
    
    // Label injection
    for i = 1:length(idx)
        v = curr_data(i);
        if v > 0 then
            offset_y = 1.0;
        elseif v < 0 then
            offset_y = -1.8;
        else
            offset_y = 1.0;
        end
        
        // Changed format from (x; y) to [x, y]
        label_str = msprintf("[%d, %g]", idx(i), v);
        xstring(idx(i) - 0.25, v + offset_y, label_str);
        
        txt_ent = gce(); 
        txt_ent.font_foreground = color(txt_colors(k)); 
        txt_ent.font_size = 2;
    end
end
