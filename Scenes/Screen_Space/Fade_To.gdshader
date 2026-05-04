shader_type canvas_item;
uniform float fade_factor = 0.02;
uniform vec4 targetColor : source_color = vec4(1.0);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_color = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec2 uv = UV;
	COLOR = mix(screen_color, targetColor, fade_factor);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
