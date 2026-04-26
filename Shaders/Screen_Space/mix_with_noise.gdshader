shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec4 mix_color : source_color = vec4(0.0, 0.0, 0.0, 0.0);
uniform float random_multiplier = 0.01;
uniform float mix_baseline = 0.0;
uniform float noise_step = 0.002;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	float time = TIME;
	vec4 screen_color = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec2 uv = UV;
	vec2 snapped_uv = vec2(round((uv.x + noise_step) / noise_step) * noise_step,round(uv.y / noise_step) * noise_step);
	COLOR = mix(screen_color, mix_color, random(snapped_uv * random_multiplier * time) + mix_baseline);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
