shader_type canvas_item;
varying vec2 particle_world_position;
void vertex() {
	particle_world_position = INSTANCE_CUSTOM.xy;
}

void fragment() {
	COLOR = vec4(particle_world_position * SCREEN_PIXEL_SIZE, 0.0, COLOR.z);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
