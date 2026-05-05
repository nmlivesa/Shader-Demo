shader_type particles;

uniform sampler2D noise_texture : filter_nearest_mipmap;
uniform float area_size = 1080.0;
uniform float area_margin = 50.0;
vec2 random(vec2 uv) {
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}
vec2 wrap(vec2 position) {
	float margin = area_margin + area_size;
	return vec2(position.x - step(margin, position.x) * margin, position.y - step(margin, position.y) * margin) +
	vec2(margin - step(area_size, position.x + margin) * margin, margin - step(area_size, position.y + margin) * margin);
}

void start() {
	float offset = float(NUMBER * INDEX);
	TRANSFORM[3].xy = vec2(area_size, area_size * random(vec2(offset, offset)).x );
	float angle = texture(noise_texture, TRANSFORM[3].xy / area_size).x * 2.0 * PI;
	vec2 direction = vec2(cos(angle), sin(angle));
	VELOCITY.xy = vec2(340.0) * direction;
	
}

void process() {
	vec2 position = TRANSFORM[3].xy;
	 
	float angle = texture(noise_texture, position / (area_size + area_margin)).x * 2.0 * PI;
	vec2 direction = vec2(cos(angle), sin(angle));
	VELOCITY.xy = mix(VELOCITY.xy, vec2(240.0) * direction, DELTA * 2.0) ;
	TRANSFORM[3].xy = wrap(position);
}

