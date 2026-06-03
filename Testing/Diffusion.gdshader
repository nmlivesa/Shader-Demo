shader_type canvas_item;
instance uniform float blur_amount : hint_range(0.0, 10.0);
instance uniform float pixel_offset = 0.0;
instance uniform float fixed_offset;
instance uniform vec2 fixed_offset_vec2;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap, repeat_enable;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	vec2 offset =(vec2(fixed_offset) + fixed_offset_vec2 + vec2(pixel_offset)) / vec2(textureSize(SCREEN_TEXTURE, 0));//(vec2(1.0) * vec2(textureSize(SCREEN_TEXTURE, 0 * int(blur_amount))));//SCREEN_PIXEL_SIZE;
	vec4 neighbor_avg = (textureLod(SCREEN_TEXTURE, uv + vec2(offset.x, 0.0), blur_amount) +
	textureLod(SCREEN_TEXTURE, uv - vec2(offset.x, 0.0), blur_amount) +
	textureLod(SCREEN_TEXTURE, uv + vec2(0.0, offset.y), blur_amount) +
	textureLod(SCREEN_TEXTURE, uv - vec2(0.0, offset.y), blur_amount)) /
	4.0;
	//offset = vec2(1.0) / vec2(textureSize(SCREEN_TEXTURE, 0));
	//neighbor_avg =textureLod(SCREEN_TEXTURE, uv + vec2(0.0, offset.y), 0);
	COLOR = COLOR + (neighbor_avg) * 1.00;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
