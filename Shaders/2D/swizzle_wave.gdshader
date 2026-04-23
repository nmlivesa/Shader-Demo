shader_type canvas_item;


global uniform vec4 primary_color;
global uniform vec4 secondary_color;
global uniform vec4 highlight_color;
global uniform bool use_uv_color;
global uniform float y_offset;
global uniform float x_offset;
global uniform float amplitude;
global uniform float speed;
global uniform float wavelength;

void fragment() {
	vec2 uv = UV;
	float swizzle = sin(uv.x * (2.0 / wavelength) + TIME * speed) * amplitude + y_offset;
	//uv = mix(uv, uv.yx , 1.0);
	uv.y += swizzle;
	if (uv.x > 1.0 || uv.x < 0.0) {
		discard;
	}
	vec4 color = texture(TEXTURE, uv);
	if (use_uv_color) {
		color = vec4(uv, 0.0,1.0);
	}
	COLOR = color;
}