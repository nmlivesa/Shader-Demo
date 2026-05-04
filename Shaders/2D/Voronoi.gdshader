shader_type canvas_item;

uniform float column = 15.0;
uniform float row = 10.0;
uniform float min_distance = 0.01;
uniform vec4 color : source_color = vec4(1.0);

vec2 random(vec2 uv) {
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

vec2 voronoi(vec2 uv, float columns, float rows) {
	
	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));
	
	float minimum_dist = 1.0;  
	vec2 minimum_point;

	for (int y= -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);
			
			point = 0.5 + 0.5 * sin(TIME + 6.2831 * point);
			
			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);
			
			if(dist < minimum_dist) {
				minimum_dist = dist;
				minimum_point = point;
			}
		}
	}
	return minimum_point + 1. - step(min_distance, minimum_dist);
}// minimum_point *0.0 + minimum_dist + 1.0 - step(min_distance, minimum_dist); // decent cellular

void fragment() {
	float voronoi = voronoi(UV, column, row).r;
	COLOR = vec4((color * voronoi).xyz, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
