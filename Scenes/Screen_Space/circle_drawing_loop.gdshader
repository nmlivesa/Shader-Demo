shader_type canvas_item;
uniform vec4 drawColor : source_color = vec4(1.0);
uniform int num_points = 1;
uniform int display_points_above = 0;
uniform float margin = 5.0;
uniform float speed_base = 1.0;
uniform float speed_mult = 1.0;
uniform vec2 origin = vec2(0.5, 0.5);
uniform float radius_base = 1.0;
uniform float radius_mult = 1.0;
uniform vec4 lineColor : source_color = vec4(1.0);
uniform float line_size = 1.0;

void vertex() {
	
	//COLOR = vec4(UV,0.0, 1.0);
}

float line(vec2 p1, vec2 p2, float width, vec2 uv)
{
	float dist = distance(p1, p2); // Distance between points
	float dist_uv = distance(p1, uv); // Distance from p1 to current pixel

	// If point is on line, according to dist, it should match current UV
	// Ideally the '0.001' should be SCREEN_PIXEL_SIZE.x, but we can't use that outside of the fragment function.
	return 1.0 - floor(1.0 - (0.001 * width) + distance (mix(p1, p2, clamp(dist_uv / dist, 0.0, 1.0)),  uv));
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec2 uv = UV;
	float time = TIME;
	//vec2 circle = (vec2(cos(TIME * speed_base), sin(TIME * speed_base))) * 0.1 + 0.5;
	vec2 center = origin;
	COLOR = vec4(0.0);
	if (length(uv - center) < margin * SCREEN_PIXEL_SIZE.x && 0 > display_points_above) {
			COLOR = drawColor;
	}
	float speed = speed_base;
	float radius = radius_base;
	vec4 draw_color_multiplied = drawColor;
	for (int i = 1; i <= num_points; i++) {
		vec2 loop_circle =(vec2(cos(TIME * speed), sin(TIME * speed))) * 0.1 * radius + center;
		if (line(center, loop_circle, line_size, uv) > 0.0 && i > display_points_above + 1) {
			COLOR = lineColor;
		}
		if (length(uv - loop_circle) < margin * SCREEN_PIXEL_SIZE.x && i > display_points_above) {
			COLOR = draw_color_multiplied;
		}
		center = loop_circle;
		speed *= speed_mult; //sin(time / 30.0);
		radius *= radius_mult;
		//draw_color_multiplied *= (1.0 + 2.0 / float(num_points));
	}

}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
