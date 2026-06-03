shader_type canvas_item;
render_mode blend_disabled;

uniform float fade_constant = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	vec3 color = texture(SCREEN_TEXTURE, uv).xyz;
	if (length(color) > 0.0) {
		color -= fade_constant * 0.0018;
	}
	/*if (length(color) > 1.5){
		color *= 0.9;
	}*/
	COLOR = vec4(color, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
