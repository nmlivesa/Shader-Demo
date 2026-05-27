shader_type canvas_item;
uniform vec2 grid = vec2(15.0, 10.0);
uniform vec4 color_line : source_color;
uniform float line_width = 1.0;
uniform vec4 color_circle : source_color;
uniform float circle_radius = 2.5;
instance uniform bool show_vectors = true;

float line(vec2 p1, vec2 p2, float width, vec2 uv)
{
	float dist = distance(p1, p2);
	float dist_uv = distance(p1, uv);
	return 1.0 - floor(1.0 - ( width) + distance (mix(p1, p2, clamp(dist_uv / dist, 0.0, 1.0)),  uv));
}

vec4 draw_direction(vec2 uv, vec2 pixel_size, sampler2D tex) {
	
	vec2 index_uv = floor(uv * grid)/ grid;
	vec2 fract_uv = fract(uv * grid);
	//return texture(tex, index_uv );
	vec4 sample = texture(tex, index_uv );
	float angle = ((sample.x + sample.y + sample.z) / 3.0) * 2.0 * PI * sample.a;
	//float angle = texture(tex, index_uv).x * 2.0 * PI;
	vec2 direction = vec2(cos(angle), sin(angle));
	if (!show_vectors){
		return vec4((direction + 1.0) / 2.0, 0.0, 1.0);

	}

	//direction /= (grid_size * 3.0);
	//vec2 direction = vec2(1.0, 1.0);
	index_uv += 0.5 / grid;
	
	float in_circle = float(length(uv - index_uv) < pixel_size.x * circle_radius); 
	float on_line = line(index_uv , index_uv + (direction) / (grid * 2.5),  pixel_size.x * line_width, uv) * (1.0 - in_circle);
	
	return color_line * on_line + color_circle * in_circle;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	
	//COLOR = color_line * line(vec2(0.5), vec2(0.7, 0.5), 1.0, uv);
	COLOR = draw_direction(uv, SCREEN_PIXEL_SIZE, TEXTURE);
	//COLOR = color_line * texture(noise_texture, uv);
}


