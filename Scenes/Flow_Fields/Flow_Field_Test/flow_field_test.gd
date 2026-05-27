extends Control
@export var particle_shader_node : ColorRect
@export var particle_velocity: float = 300.0
var particle_shader : ShaderMaterial;
var particle_shader_size : Vector2;
var image : Image;
var image_size : Vector2;
var particle_position : Vector2 = Vector2(0.5, 0.5)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	await RenderingServer.frame_post_draw
	var texture : ViewportTexture = $SubViewport.get_texture()
	image = texture.get_image()
	image_size = image.get_size()
	particle_shader = particle_shader_node.material
	particle_shader_size = particle_shader_node.size
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction_color = (image.get_pixelv(particle_position * image_size))
	#print_debug(image_size)
	#print_debug(direction_color)
	var direction = (Vector2(direction_color.r, direction_color.g) * 2.0) - Vector2(1.0, 1.0)
	#print_debug(direction)
	particle_position += (direction / particle_shader_size) * particle_velocity * delta
	particle_position = Vector2(wrapf(particle_position.x, 0.0, 1.0), wrapf(particle_position.y, 0.0, 1.0))
	particle_shader.set_shader_parameter("p1", particle_position)


func get_direction(sample_point : Vector2) -> Vector2:
	pass
	var direction_color = (image.get_pixelv(sample_point * image_size))
	return (Vector2(direction_color.r, direction_color.g) * 2.0) - Vector2(1.0, 1.0)
