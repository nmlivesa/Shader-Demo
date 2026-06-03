shader_type canvas_item;
uniform vec2 point_array[1000];
uniform vec3 color_array[1000];
uniform int points_used : hint_range(1, 1000, 1);

void vertex() {
	// Called for every vertex the material is visible on.
}
vec3 voronoi_color(vec2 uv) {
	int nearest_point_index = 0;
	float shortest_distance = length(uv- point_array[0]);
	for (int i = 1; i < points_used; i++){
		float new_distance = length(uv- point_array[i]);
		if (new_distance < shortest_distance) {
			nearest_point_index = i;
			shortest_distance = new_distance;
		}
	}
	return color_array[nearest_point_index];
}
void fragment() {
	vec2 uv = UV;
	COLOR = vec4(voronoi_color(uv), 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
