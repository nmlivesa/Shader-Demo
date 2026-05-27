shader_type particles;
uniform float attractor_mult = 1.0;
uniform vec3 start_position = vec3(0.0);
uniform vec3 start_position_offset = vec3(0.0);
uniform vec3 initial_velocity = vec3(0.0);
uniform vec3 initial_velocity_range = vec3(0.0);
uniform float max_speed = 1.0;
uniform float wrap_radius = 20.0;
uniform float wrap_mult = 0.95;
float rand_from_seed(inout uint seed) {
	int k;
	int s = int(seed);
	if (s == 0) {
		s = 305420679;
	}
	k = s / 127773;
	s = 16807 * (s - k * 127773) - 2836 * k;
	if (s < 0) {
		s += 2147483647;
	}
	seed = uint(s);
	return float(seed % uint(65536)) / 65535.0;
}

float rand_from_seed_m1_p1(inout uint seed) {
	return rand_from_seed(seed) * 2.0 - 1.0;
}

uint hash(uint x) {
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = (x >> uint(16)) ^ x;
	return x;
}

vec3 wrap(vec3 position) {
	if (length(position) > wrap_radius) {
		return position * -wrap_mult;
	}
	return position;
}

void start() {
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	
	// spawn on circle on xz axis scaled by start position
	float angle_rads = rand_from_seed(alt_seed) * 2.0 * PI;
	vec2 pos_on_circle = vec2(cos(angle_rads),sin(angle_rads));
	TRANSFORM[3].xyz = vec3(start_position.x * pos_on_circle.x, start_position.y, start_position.z * pos_on_circle.y) + start_position_offset;
	
	//idk. just a thing
	//TRANSFORM[3].xyz = vec3(-20.0 * rand_from_seed_m1_p1(alt_seed), 0.0, 50.0 * rand_from_seed_m1_p1(alt_seed));
	
	VELOCITY = initial_velocity + initial_velocity_range * rand_from_seed(alt_seed);
}

void process() {
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	vec3 velocity = VELOCITY;
	velocity += ATTRACTOR_FORCE * DELTA * attractor_mult;
	if (length(velocity) > max_speed) {
		velocity = (velocity / length(velocity)) * max_speed;
	}
	VELOCITY = velocity;
	//COLOR = vec4(ATTRACTOR_FORCE, 1.0);
	TRANSFORM[3].xyz = wrap(TRANSFORM[3].xyz);
}
