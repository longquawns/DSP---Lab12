clear; clc; clf();

// 1. Base signal x[n] = {1, -2, 3, 6}
idx_base = -2:1;
val_base = [1, -2, 3, 6];

// 2. Manipulated signal y2[n] = x[n+3]
idx_y2 = idx_base - 3;
val_y2 = val_base;

// --- Plotting Block ---
arr_sigs = list(val_base, val_y2);
arr_idx = list(idx_base, idx_y2);
plot_titles = ["Reference Signal: x[n]", "Phase Advance: y2[n] = x[n+3]"];
txt_colors = ["darkblue", "forestgreen"];
marker_styles = ["bs", "gs"]; 

for k = 1:2
    subplot(2, 1, k);
    c_idx = arr_idx(k);
    c_sig = arr_sigs(k);
    
    plot2d3(c_idx, c_sig);
    plot(c_idx, c_sig, marker_styles(k));
    
    title(plot_titles(k), "fontsize", 3); 
    xlabel("Time Index [n]"); ylabel("Amplitude");
    
    ax = gca(); 
    ax.x_location = "origin"; 
    ax.data_bounds = [-6.5, -4; 2.5, 8]; 
    ax.grid = [1, 1];
    
    y_range = [-4:2:8]'; 
    ax.y_ticks = tlist(["ticks", "locations", "labels"], y_range, string(y_range));
    
    for i = 1:length(c_idx)
        v = c_sig(i);
        offset_y = (v >= 0) * 1.0 + (v < 0) * -1.5;
        txt_label = msprintf("{%d, %g}", c_idx(i), v);
        xstring(c_idx(i) - 0.25, v + offset_y, txt_label);
        
        txt_ent = gce(); 
        txt_ent.font_foreground = color(txt_colors(k)); 
        txt_ent.font_size = 2;
    end
end
