shader_type particles;
uniform vec3 dimensions = vec3(2.0);
uniform float point_count = 4.0;
uniform float attractor_mult = 0.001;
uniform float wrap_radius = 20.0;
uniform float wrap_mult = 0.95;

vec3 point_on_grid(float index){ // vec3 dimensions, float point_count) // use when not already in uniforms
	// this will extend out in z direction for overflow points!
	float depth = floor(index / (point_count * point_count));
	float column = floor((index - (depth * point_count * point_count)) / point_count); 
	// subtract 
	float row = fract(index / point_count) * point_count;

	vec3 grid_location = vec3(row, column, depth) / (point_count - 1.0);
	return (grid_location * dimensions) - (dimensions / 2.0); // ranges from -dimension/2 to dimension/2
	//return grid_location * dimensions; // ranges from 0 to dimension
}
vec3 wrap(vec3 position) {
	if (length(position) > wrap_radius) {
		return position * -wrap_mult;
	}
	return position;
}

void start() {
	// Called when a particle is spawned.
	/*float index = float(INDEX);
	float depth = floor(index / (point_count * point_count));
	float column = floor((index - (depth * point_count * point_count)) / point_count); 
	// subtract 
	float row = fract(index / point_count) * point_count;

	vec3 grid_location = vec3(row, column, depth) / (point_count - 1.0); */
	// for 4 points(0,1,2,3) to evenly space across a 0 to 1 grid, divide b 3
	TRANSFORM[3].xyz = point_on_grid(float(INDEX));
	VELOCITY = vec3(0.0);
	
	
}

void process() {
	VELOCITY = ATTRACTOR_FORCE * attractor_mult;
	TRANSFORM[3].xyz = wrap(TRANSFORM[3].xyz);
	COLOR = vec4(ATTRACTOR_FORCE, 1.0);
	// Called every frame on existing particles (according to the Fixed FPS property).
}
