shader_type particles;
uniform float kernel_offset = 75.0;
uniform float kernel_size = 50.0;
uniform float kernel_blur = 0.0;
uniform float vision_cone = 0.75;
uniform float rotation = 0.1;
uniform float flow_delta_weight = 1.0;
uniform float flow_fixed_weight = 0.0;
uniform float start_speed = 100.0;
uniform float target_speed = 150.0;
uniform float minimun_speed = 50.0;
uniform vec2 size = vec2(1920.0, 1080.0);
uniform vec2 area_margin = vec2(50.0, 30.0);
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

vec2 bias_vector(float index){
	//index = fract(index / PI);
	return normalize(vec2((random(fract(vec2(index * 0.0212454549, index * 42.089891423))).x * 2.0) - 1.0, 
	(random(vec2(1.0 + index)).x * 2.0) - 1.0));
}

vec2 rotate_vector(inout vec2 to_rotate, float rotation_amount) {
	to_rotate.x = to_rotate.x * cos(rotation_amount) - to_rotate.y * sin(rotation_amount);
	to_rotate.y = to_rotate.x * sin(rotation_amount) + to_rotate.y * cos(rotation_amount);
	return to_rotate;
}

void start() {
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	//From Center
	TRANSFORM[3].xy = vec2(0.5,0.5) * size;
	// random start position within starting range
	//TRANSFORM[3].xy = vec2(size.x * random(vec2(sin((0.256793 + float(INDEX) * 0.71915)))).x, size.y * random(vec2(sin(0.777777 * float(INDEX) + 0.11154))).x);
	// random start along right edge.
	//TRANSFORM[3].xy = vec2(size.x, size.y * random(vec2(sin((0.777777 * float(INDEX) + 0.11154)))).x);
	// start with velocity to the left and random y between -1 and 1
	//vec2 direction = vec2(-1.0, (random(vec2(sin(TIME + float(INDEX)), TIME)).x * 2.0) - 1.0 );
	vec2 direction = normalize(vec2(rand_from_seed_m1_p1(alt_seed), rand_from_seed_m1_p1(alt_seed)));
	
	VELOCITY.xy = vec2(start_speed) * direction;
}

vec2 wrap(vec2 position) {
	vec2 margin = size + area_margin;
	return vec2(position.x - step(margin.x, position.x) * margin.x, position.y - step(margin.y, position.y) * margin.y) +
	vec2(margin.x - step(size.x, position.x + margin.x) * margin.x, margin.y - step(size.y, position.y + margin.y) * margin.y);
}


vec2 brightest_direction(vec2 position, vec2 velocity, inout uint alt_seed) {
	float brightest_found = 0.0;
	vec2 output = vec2(0.0);
	float alignment = 1.0;
	for (float i = 0.0; i < kernel_size; i++ ) {
		// kernel as a circle, sure, why not?
		vec2 k = vec2(cos(i * 2.0 * PI / kernel_size), sin(i * 2.0 * PI / kernel_size));
		alignment = (dot(normalize(k), normalize(velocity)) + 1.0) * 0.5;
		vec4 sample = textureLod(flow_tex, (position + (k * kernel_offset)) / size, kernel_blur);
		float current = step(vision_cone, alignment) * (sample.x + sample.y + sample.z) / 3.0;
		if (current > brightest_found + (brightest_found * 0.05)) {
			brightest_found = current;
			output = k;
		}
		/*else if (current > brightest_found- (brightest_found * 0.05)) {
			float coin_flip_rand = rand_from_seed(alt_seed);
			brightest_found = step(coin_flip_rand, 0.5) * brightest_found + step(0.5, coin_flip_rand) * current;
			output = k;
		}*/
	}
	return output;
}

void process() {
	uint base_number = NUMBER;
	uint alt_seed = hash(base_number + uint(1) + RANDOM_SEED);
	// get position from transform matrix
	vec2 position = TRANSFORM[3].xy;
	vec2 velocity = VELOCITY.xy;
	vec2 direction = brightest_direction(position, velocity, alt_seed);
	
	velocity= mix(velocity, vec2(target_speed) * direction, (DELTA * flow_delta_weight) + flow_fixed_weight);
	if (length(velocity) < minimun_speed) {
		velocity = (velocity / length( velocity)) * minimun_speed;
	}
	//velocity = (velocity * 0.98) + (length(velocity) * 0.04 *  bias_vector(float(INDEX)));
	rotate_vector(velocity, rotation * DELTA * rand_from_seed_m1_p1(alt_seed));
	VELOCITY.xy = velocity;// + weight_vector(float(INDEX)) * minimun_speed;
	TRANSFORM[3].xy = wrap(position);
}
