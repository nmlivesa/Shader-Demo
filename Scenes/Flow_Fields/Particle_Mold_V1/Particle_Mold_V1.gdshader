shader_type particles;
uniform float kernel_offset = 75.0;
uniform float kernel_size = 50.0;
uniform float kernel_blur = 0.0;
uniform float vision_cone = 0.75;
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

void start() {
	// random start position within starting range
	TRANSFORM[3].xy = vec2(size.x * random(vec2(sin((0.256793 + float(INDEX) * 0.71915)))).x, size.y * random(vec2(sin(0.777777 * float(INDEX) + 0.11154))).x);
	// random start along right edge.
	//TRANSFORM[3].xy = vec2(size.x, size.y * random(vec2(sin((0.777777 * float(INDEX) + 0.11154)))).x);
	// start with velocity to the left and random y between -1 and 1
	//vec2 direction = vec2(-1.0, (random(vec2(sin(TIME + float(INDEX)), TIME)).x * 2.0) - 1.0 );
	vec2 direction = vec2((random(vec2(sin((0.4525654 + float(INDEX) * 0.32146)))).x * 2.0) - 1.0, (random(vec2(sin(0.9323756 *  float( INDEX ) - 0.45554477))).x * 2.0) - 1.0);
	VELOCITY.xy = vec2(start_speed) * direction;
}

vec2 wrap(vec2 position) {
	vec2 margin = size + area_margin;
	return vec2(position.x - step(margin.x, position.x) * margin.x, position.y - step(margin.y, position.y) * margin.y) +
	vec2(margin.x - step(size.x, position.x + margin.x) * margin.x, margin.y - step(size.y, position.y + margin.y) * margin.y);
}

vec2 brightest_direction(vec2 position, vec2 velocity) {
	float brightest_found = 0.0;
	vec2 output = vec2(0.0,0.00001);
	float alignment = 1.0;
	for (float i = 0.0; i < kernel_size; i++ ) {
		// kernel as a circle, sure, why not?
		vec2 k = vec2(cos(i * 2.0 * PI / kernel_size), sin(i * 2.0 * PI / kernel_size));
		alignment = (dot(normalize(k), normalize(velocity)) + 1.0) * 0.5;
		if (alignment < vision_cone){
			alignment = 0.0;
		}
		// should adjust so sample
		vec4 sample = textureLod(flow_tex, (position + (k * kernel_offset)) / size, kernel_blur);
		if (alignment * (sample.x + sample.y + sample.z) / 3.0 > brightest_found) {
			brightest_found = (sample.x + sample.y + sample.z) / 3.0;
			output = k;
		}
	}
	return output;
}

void process() {
	// get position from transform matrix
	vec2 position = TRANSFORM[3].xy;
	vec2 velocity = VELOCITY.xy;
	vec2 direction = brightest_direction(position, velocity);
	
	velocity= mix(velocity, vec2(target_speed) * direction, (DELTA * flow_delta_weight) + flow_fixed_weight);
	
	if (length(velocity) < minimun_speed) {
		velocity = (velocity / length( velocity)) * minimun_speed;
	}
	VELOCITY.xy = velocity;
	TRANSFORM[3].xy = wrap(position);
}
