// ==========================================
// EXERCISE 8C: Composite Transformation
// ==========================================
clear; clc; clf();

// 1. Base signal x[n] = {1, -2, 3, 6}
idx_base = -2:1;
val_base = [1, -2, 3, 6];

// 2. Manipulated signal y3[n] = 2x[-n-2]
idx_y3 = -idx_base($:-1:1) - 2;
val_y3 = 2 * val_base($:-1:1);

// --- Plotting Block ---
arr_sigs = list(val_base, val_y3);
arr_idx = list(idx_base, idx_y3);
plot_titles = ["Reference Signal: x[n]", "Composite Function: y3[n] = 2x[-n-2]"];
txt_colors = ["darkblue", "purple"];
marker_styles = ["bs", "ms"]; 

for k = 1:2
    subplot(2, 1, k);
    c_idx = arr_idx(k);
    c_sig = arr_sigs(k);
    
    plot2d3(c_idx, c_sig);
    plot(c_idx, c_sig, marker_styles(k));
    
    title(plot_titles(k), "fontsize", 3); 
    xlabel("[n]"); ylabel("Amplitude");
    
    ax = gca(); 
    ax.x_location = "origin"; 
    // Mở rộng giới hạn đồ thị trục Y lên 16 để không bị cắt chữ
    ax.data_bounds = [-4.5, -6; 2.5, 16]; 
    ax.grid = [1, 1];
    
    // Cập nhật các vạch chia trên trục Y cho đồng bộ với data_bounds mới
    y_range = [-6:2:16]'; 
    ax.y_ticks = tlist(["ticks", "locations", "labels"], y_range, string(y_range));
    
    for i = 1:length(c_idx)
        v = c_sig(i);
        // Giảm khoảng cách (offset_y) từ 1.5 xuống 1.0 để nhãn nằm sát điểm dữ liệu hơn
        offset_y = (v >= 0) * 1.0 + (v < 0) * -1.8;
        txt_label = msprintf("{%d, %g}", c_idx(i), v);
        xstring(c_idx(i) - 0.25, v + offset_y, txt_label);
        
        txt_ent = gce(); 
        txt_ent.font_foreground = color(txt_colors(k)); 
        txt_ent.font_size = 2;
    end
end
