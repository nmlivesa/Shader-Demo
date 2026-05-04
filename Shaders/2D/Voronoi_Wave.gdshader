shader_type canvas_item;

global uniform vec4 primary_color;
global uniform vec4 secondary_color;
global uniform vec4 highlight_color;
global uniform bool use_uv_color;
global uniform float highlight_size;

global uniform float y_offset;
global uniform float x_offset;
global uniform float amplitude;
global uniform float speed;
global uniform float wavelength;

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

vec2 voronoi(in vec2 uv,in float columns,in float rows, out float distance_diff) {
	float time = TIME;
	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));
	
	float minimum_dist = 1.0;  
	float minimum_dist_2 = 1.0;
	vec2 minimum_point;
	//vec2 minimum_diff;
	//vec2 minimum_diff_2;

	for (int y= -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);
			
			//point.x = 0.5 + 0.5 * sin(time + 6.2831 * point.x);
			//point = sin((6.2831 / wavelength) * point + time * speed) * 0.5 * amplitude + 0.5 + y_offset;
			
			point.y = sin((6.2831 / wavelength) * point.x + time  * speed) * 0.5 * amplitude + 0.5 + y_offset;
			point.x = sin((6.2831 / wavelength) * point.x + time  * speed) * 0.5 * amplitude + 0.5 + y_offset;
			
			
			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);
			if (dist < minimum_dist_2 && dist > minimum_dist) {
				minimum_dist_2 = dist;
				//minimum_diff_2 = diff;
			}
			if(dist < minimum_dist) {
				minimum_dist_2 = minimum_dist;
				//minimum_diff_2 = minimum_diff;
				//minimum_diff = diff;
				minimum_dist = dist;
				minimum_point = point;
			}
			
		}
	}
	//if (minimum_dist_2 - minimum_dist < highlight_size / 2.0 && dot(minimum_point - vec2(uv.x * columns, uv.y * rows), minimum_point_2 - vec2(uv.x * columns, uv.y * rows)) > 0.0){
	//if (minimum_dist_2 - minimum_dist < highlight_size / 2.0 && dot(minimum_diff, minimum_diff_2) < 0.0) { // this has a neat partial outline
	//float temp_dist = minimum_dist;
	//minimum_dist += highlight_size;
	if (minimum_dist_2 - minimum_dist < highlight_size / 2.0) {
		minimum_dist = minimum_dist_2 - minimum_dist;
	}
	distance_diff = minimum_dist; // need min distance for point coloring
	return minimum_point;// + 1. - step(min_distance, minimum_dist); // evaluate point in fragment now
}
void fragment() {
	float distance_diff;
	vec2 voronoi = voronoi(UV, column, row, distance_diff);
	vec4 voronoi_color = mix(primary_color , secondary_color, voronoi.r);
	voronoi_color = mix(voronoi_color, highlight_color, 1. - step(highlight_size / 2.0, distance_diff));// smoothstep(0.0, highlight_size / 2.0, distance_diff));
	COLOR = vec4(voronoi_color.xyz, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
