shader_type particles;

uniform float field_weight = 1.0;
uniform float start_speed = 100.0;
uniform float target_speed = 150.0;
uniform vec2 size = vec2(1920.0, 1080.0);
uniform float area_margin = 50.0;
uniform sampler2D noise_texture : filter_nearest_mipmap;

vec2 random(vec2 uv) {
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}
vec2 wrap(vec2 position) {
	vec2 margin = size + area_margin;
	return vec2(position.x - step(margin.x, position.x) * margin.x, position.y - step(margin.y, position.y) * margin.y) +
	vec2(margin.x - step(size.x, position.x + margin.x) * margin.x, margin.y - step(size.y, position.y + margin.y) * margin.y);
}

void start() {
	
	TRANSFORM[3].xy = vec2(size.x, size.y * sin(float(INDEX)));
	vec2 direction = vec2(-1.0, 0.0);
	VELOCITY.xy = vec2(start_speed) * direction;
	
}

void process() {
	vec2 position = TRANSFORM[3].xy;
	 
	float angle = texture(noise_texture, position / (size + area_margin)).x * 2.0 * PI;
	vec2 direction = vec2(cos(angle), sin(angle));
	VELOCITY.xy = mix(VELOCITY.xy, vec2(target_speed) * direction, DELTA * field_weight);
	//VELOCITY += COLLISION_NORMAL * COLLISION_DEPTH * 50.0;
	TRANSFORM[3].xy = wrap(position);
	
}

