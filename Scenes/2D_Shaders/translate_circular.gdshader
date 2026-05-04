shader_type canvas_item;

global uniform bool use_uv_color;
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
	float time = TIME;
	uv += vec2(cos(TIME), sin(TIME)) * 0.2;
	if (uv.x > 1.0 || uv.x < 0.0 || uv.y > 1.0 || uv.y < 0.0) {
		discard;
	}
	vec4 color = texture(TEXTURE, ((uv) * 2.0)- 0.5);
	if (use_uv_color) {
		color = vec4(uv, 0.0,1.0);
	}
	COLOR = color;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
