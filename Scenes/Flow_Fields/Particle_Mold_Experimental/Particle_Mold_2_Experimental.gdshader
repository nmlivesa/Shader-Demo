shader_type particles;
uniform float sample_angle = 0.1;
uniform float start_speed = 100.0;
uniform float target_speed = 50.0;
uniform float minimun_speed = 50.0;
uniform vec2 size = vec2(1920.0, 1080.0);
uniform sampler2D flow_tex : filter_linear;


vec2 random(vec2 uv) {//returns psuedorandom value between 0 and 1. Both elements are equal.
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}

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

vec2 rotate_vec2(vec2 vector, float angle) {
	vector.x = vector.x * cos(angle) - vector.y * sin(angle);
	vector.y = vector.x * sin(angle) + vector.y * cos(angle);
	return vector;
}


void start() {
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	//From Center
	float rand_angle = rand_from_seed(alt_seed) * TAU;
	float offset_from_center = (rand_from_seed(alt_seed) * 0.0) + 0.1;
	vec2 start_pos = (vec2(sin(rand_angle), cos(rand_angle)) * offset_from_center * min(size.x, size.y)) + vec2(0.5,0.5) * size;
	TRANSFORM[3].xy = start_pos;
	//vec2 direction = normalize(vec2(rand_from_seed_m1_p1(alt_seed), rand_from_seed_m1_p1(alt_seed)));
	vec2 direction = normalize( vec2(0.5)*size - start_pos);
	VELOCITY.xy = vec2(start_speed) * rotate_vec2(direction, 0.0);
	
}

void bounce(inout vec2 position, inout vec2 velocity ){
	if (position.x < 0.0 || position.y < 0.0 || position.x >= size.x || position.y >= size.y){
		position.x = min(size.x - 0.01, max(0, position.x));
		position.y = min(size.y - 0.01, max(0, position.y));
		velocity *= -1.0; //fix later.
	}
	else {
		
	}
}

vec2 sample_colors(){
	return vec2(0.0);
}



void process() {
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	// get position from transform matrix
	vec2 position = TRANSFORM[3].xy;
	vec2 velocity = VELOCITY.xy;
	float mag = length(velocity);
	bounce(position, velocity);
	
	velocity = (velocity / length(velocity)) * mag;
	TRANSFORM[3].xy = position;
	VELOCITY.xy = velocity;
	CUSTOM.xyz = TRANSFORM[3].xyz;
}
