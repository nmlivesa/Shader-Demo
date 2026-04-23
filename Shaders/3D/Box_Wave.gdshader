shader_type spatial;

global uniform vec4 primary_color;
global uniform vec4 secondary_color;
global uniform vec4 highlight_color;
global uniform bool use_uv_color;
global uniform float y_offset;
global uniform float amplitude;
global uniform float speed;
global uniform float wavelength;


void vertex() {
	//COLOR.xyz = vec3(VERTEX.x, VERTEX.y, VERTEX.z);
	VERTEX.y += sin(VERTEX.x * (2.0 / wavelength) + TIME * speed) * amplitude +  y_offset;// * sin(VERTEX.z + TIME * speed);
	//VERTEX.y *= sin(VERTEX.x + TIME * speed) * amplitude + (1.0 - y_offset);
}

void fragment() {
	//ALBEDO = vec3(COLOR.xyz);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
