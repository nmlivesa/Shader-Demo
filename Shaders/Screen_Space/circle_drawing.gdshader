shader_type canvas_item;

uniform vec4 drawColor : source_color = vec4(1.0);
uniform float margin = 0.002;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.

	vec2 uv = UV;
	float time = TIME;
	vec2 circle = (vec2(cos(TIME), sin(TIME))) * 0.5 + 0.5;
	
	
	if (length(uv - circle) < margin) {
		COLOR = drawColor;
	}
	else {
		discard;
	}
	
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
