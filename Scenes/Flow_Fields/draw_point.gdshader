shader_type canvas_item;

uniform float point_size = 5.0;
uniform vec4 point_color : source_color = vec4(1.0);
uniform vec4 background_color : source_color = vec4(1.0);
uniform vec2 p1 = vec2(0.5, 0.5);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	COLOR = mix(background_color, point_color, float(length(uv - p1) < point_size * SCREEN_PIXEL_SIZE.x));
	
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
