shader_type canvas_item;

uniform int cells = 8;
uniform vec4 light_col : source_color = vec4(0.13, 0.92, 0.18, 1.0); // bright green
uniform vec4 dark_col  : source_color = vec4(1.0, 0.14, 0.55, 1.0);  // bright pink
uniform float line_thickness = 0.045;  // in UV units (0..1 across the board)
uniform vec4 line_col : source_color = vec4(0.0, 0.0, 0.0, 1.0);     // black

void fragment() {
    // UV goes 0..1 across the ColorRect
    vec2 uv = UV;

    // Which square are we in?
    vec2 cell = floor(uv * float(cells));
    float parity = mod(cell.x + cell.y, 2.0);
    vec4 base = mix(light_col, dark_col, parity);

    // Grid lines (no perspective)
    vec2 f = fract(uv * float(cells));
    float edge = min(min(f.x, f.y), min(1.0 - f.x, 1.0 - f.y));
    float is_line = step(edge, line_thickness);

    COLOR = mix(base, line_col, is_line);
}
