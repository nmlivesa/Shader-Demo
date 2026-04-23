shader_type canvas_item;

global uniform vec4 primary_color;
global uniform vec4 secondary_color;
global uniform vec4 highlight_color;
global uniform bool use_uv_color;
//uniform float surface_width = 0.025;
global uniform float highlight_size;
global uniform float y_offset;
global uniform float x_offset;
global uniform float amplitude;
global uniform float speed;
global uniform float wavelength;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	float wave_height = sin(uv.x * (2.0 / wavelength) + TIME * speed) * amplitude  + 0.5 + y_offset;
	if (uv.y > wave_height) {
		COLOR = primary_color;
		if (use_uv_color) {
			COLOR = vec4(uv, 0.0,1.0);
		}
	}
	else {
		COLOR = secondary_color;
		if (use_uv_color) {
			COLOR = vec4(uv, 0.0,1.0);
		}
	}
	if (uv.y > wave_height - (highlight_size) / 2.0) if (uv.y < wave_height + (highlight_size) / 2.0) {
		COLOR = highlight_color;
	}
}

