shader_type canvas_item;



uniform float point_size = 180.0;
uniform vec4 point_color : source_color = vec4(1.0);
uniform vec4 sample_point_color : source_color = vec4(1.0);
uniform vec4 background_color : source_color = vec4(0.0);

const vec2 p1 = vec2(0.5, 0.5);

void vertex() {
	// Called for every vertex the material is visible on.
}
vec4 brightest_direction(vec2 uv, sampler2D flow_tex) {
	vec2 position = vec2(0.5, 0.5);
	float kernel_offset = 500.0;
	float kernel_size = 7.0;
	float kernel_blur = 3.75;
	vec4 output = background_color;
	for (float i = 0.0; i < kernel_size; i++ ) {
		// kernel as a circle, sure, why not?
		vec2 k = vec2(cos(i * 2.0 * PI / kernel_size), sin(i * 2.0 * PI / kernel_size));
		vec4 sample = textureLod(flow_tex, position + (k * kernel_offset), kernel_blur);
		
	}
	return output;
}

void fragment() {
	vec2 uv = UV;
	COLOR = mix(background_color, point_color, float(length(uv - p1) < point_size  * SCREEN_PIXEL_SIZE.x));
	
	
}