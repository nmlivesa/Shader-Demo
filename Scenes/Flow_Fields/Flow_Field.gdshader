shader_type canvas_item;

uniform vec4 color_line : source_color;
uniform sampler2D noise_texture : filter_nearest_mipmap;

float line(vec2 p1, vec2 p2, float width, vec2 uv)
{
	float dist = distance(p1, p2);
	float dist_uv = distance(p1, uv);
	return 1.0 - floor(1.0 - (0.001 * width) + distance (mix(p1, p2, clamp(dist_uv / dist, 0.0, 1.0)),  uv));
}

vec4 draw_direction(vec2 uv, float grid_size) {
	
	vec2 index_uv = floor(vec2(uv * grid_size)) / grid_size;
	vec2 fract_uv = fract(vec2(uv * grid_size));
	//return texture(noise_texture, uv);
	float angle = texture(noise_texture, index_uv).x * 2.0 * PI;
	vec2 direction = vec2(cos(angle), sin(angle));
	return vec4((direction + 1.0) / 2.0, 0.0, 1.0); // comment out this line to see grid of direction vectors

	//direction /= (grid_size * 3.0);
	//vec2 direction = vec2(1.0, 1.0);
	index_uv += 0.5 / grid_size;
	float on_line = line(index_uv , index_uv + (direction) / (grid_size * 3.0), 0.5, uv);
	return color_line * on_line;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	
	//COLOR = color_line * line(vec2(0.5), vec2(0.7, 0.5), 1.0, uv);
	COLOR = draw_direction(uv, 30.0);
	//COLOR = color_line * texture(noise_texture, uv);
}


