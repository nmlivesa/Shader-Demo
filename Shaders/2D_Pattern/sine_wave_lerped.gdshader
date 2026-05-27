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

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;


float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float time = TIME;
	vec4 screen_color = texture(screen_texture, SCREEN_UV, 0.0);
	vec2 uv = UV;
	float wave_height = sin(uv.x * (2.0 / wavelength) + time * speed) * amplitude  + 0.5 + y_offset;
	if (uv.y > wave_height) {
		COLOR = mix(screen_color, primary_color, random(uv * time) + x_offset);
		if (use_uv_color) {
			COLOR = vec4(uv, 0.0,1.0);
		}
	}
	else {
		COLOR = mix(screen_color, secondary_color, 0.11);
		if (use_uv_color) {
			COLOR = vec4(uv, 0.0,1.0);
		}
	}
	if (uv.y > wave_height - (highlight_size) / 2.0) if (uv.y < wave_height + (highlight_size) / 2.0) {
		COLOR = highlight_color;
	}
}

