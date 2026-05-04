shader_type canvas_item;


uniform vec4 drawColor : source_color = vec4(1.0);
uniform float margin = 0.002;
uniform float speed1 = 1.0;
uniform float speed2 = 1.0;
uniform float speed3 = 1.0;
void vertex() {
	
	//COLOR = vec4(UV,0.0, 1.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec2 uv = UV;
	float time = TIME;
	vec2 circle = (vec2(cos(TIME * speed1), sin(TIME * speed1))) * 0.1 + 0.5;
	vec2 circle2 = (vec2(cos(TIME * speed2), sin(TIME * speed2))) * 0.1 + circle;
	vec2 circle3 = (vec2(cos(TIME * speed3), sin(TIME * speed3))) * 0.1 + circle2;
	
	if (length(uv - circle) < margin || length(uv - circle2) < margin || length(uv - circle3) < margin) {
		COLOR = drawColor;
	}
	else {
		discard;
	}
	

	
	
}