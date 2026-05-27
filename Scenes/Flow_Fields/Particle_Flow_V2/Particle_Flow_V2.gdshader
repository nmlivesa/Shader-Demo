shader_type particles;

uniform float flow_delta_weight = 1.0;
uniform float flow_fixed_weight = 0.0;
uniform float start_speed = 100.0;
uniform float target_speed = 150.0;
uniform vec2 size = vec2(1920.0, 1080.);
uniform vec2 area_margin = vec2(50.0);
uniform sampler2D flow_tex : filter_nearest_mipmap;

vec2 random(vec2 uv) {//returns psuedorandom value between 0 and 1. Both elements are equal.
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}
vec2 wrap(vec2 position) {
	vec2 margin = size + area_margin;
	return vec2(position.x - step(margin.x, position.x) * margin.x, position.y - step(margin.y, position.y) * margin.y) +
	vec2(margin.x - step(size.x, position.x + margin.x) * margin.x, margin.y - step(size.y, position.y + margin.y) * margin.y);
}

void start() {
	// random start position within starting range
	TRANSFORM[3].xy = vec2(size.x * random(vec2(cos(float(INDEX)))).x, size.y * random(vec2(sin(float(INDEX)))).x);
	// random start along right edge.
	TRANSFORM[3].xy = vec2(size.x, size.y * random(vec2(sin(float(INDEX)))).x);
	// start with velocity to the left and random y between -1 and 1
	vec2 direction = vec2(-1.0, (random(vec2(sin(TIME + float(INDEX)), TIME)).x * 2.0) - 1.0 );
	VELOCITY.xy = vec2(start_speed) * direction;
}

void process() {
	// get position from transform matrix
	vec2 position = TRANSFORM[3].xy;
	// sample flow_tex with 2d coordinate with vals between 0 and 1
	vec4 sample = texture(flow_tex, position / (size + area_margin));
	// avg colors and mult by opacity to get val between 0 and 1. mult by 2PI to get val from 0 to 2PI
	float angle = ((sample.x + sample.y + sample.z) / 3.0) * 2.0 * PI * sample.a;
	// turn angle into a normalized direction vector
	vec2 direction = vec2(cos(angle), sin(angle));
	VELOCITY.xy = mix(VELOCITY.xy, vec2(target_speed) * direction, (DELTA * flow_delta_weight) + flow_fixed_weight);
	TRANSFORM[3].xy = wrap(position);
}
