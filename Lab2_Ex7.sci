// ==========================================
// EXERCISE 7: Signal Modulation / Windowing
// ==========================================
clear; clc; clf();

// 1. Time index vector
idx = -1:3;

// 2. Input sequences
seqA = [0, 0, 1, 3, -2];
seqB = [0, 1, 2, 3, 0];

// 3. Element-wise modulation
out_prod = seqA .* seqB;

// 4. Data structures for plotting
sig_arrays = list(seqA, seqB, out_prod);
plot_titles = ["Signal x1(n)", "Signal x2(n)", " Output signal y(n) = x1(n) * x2(n)"];
txt_colors = ["darkblue", "darkred", "purple"];
marker_styles = ["bd", "rd", "md"]; // d: diamond marker

for k = 1:3
    subplot(3, 1, k);
    curr_data = sig_arrays(k);
    
    plot2d3(idx, curr_data);
    plot(idx, curr_data, marker_styles(k)); 
    
    title(plot_titles(k), "fontsize", 3); 
    xlabel("Time Index [n]"); 
    ylabel("Amplitude");
    
    // Axes customization
    ax = gca(); 
    ax.x_location = "origin"; 
    ax.data_bounds = [-1.5, -4; 3.5, 12]; 
    ax.grid = [1, 1];
    
    // FORCING Y-AXIS TO SHOW EVERY INTEGER STEP
    y_range = [-4:1:12]'; 
    ax.y_ticks = tlist(["ticks", "locations", "labels"], y_range, string(y_range));
    
    // Label injection
    for i = 1:length(idx)
        v = curr_data(i);
        if v > 0 then
            offset_y = 1.5;
        elseif v < 0 then
            offset_y = -2.0;
        else
            offset_y = 1.0;
        end
        
        label_str = msprintf("[%d, %g]", idx(i), v);
        xstring(idx(i) - 0.25, v + offset_y, label_str);
        
        txt_ent = gce(); 
        txt_ent.font_foreground = color(txt_colors(k)); 
        txt_ent.font_size = 2;
    end
end
