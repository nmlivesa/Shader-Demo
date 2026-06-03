extends ColorRect

@export var animate_offset : bool = false
@export var animate_rotation : bool = false
var parent
var time : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	#var tween = create_tween().tween_property(parent, "rotation_degrees", 360.0, 10.0)
	if animate_rotation:
		rotation_animation()
	if animate_offset:
		offset_animation()

func rotation_animation():
	pass
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(parent, "scale", Vector2(0.9,0.9), 1.5)
	tween.tween_interval(1.0)
	tween.tween_property(parent, "rotation_degrees", 15.0, 1.5)
	tween.tween_interval(1.0)
	tween.tween_property(parent, "rotation_degrees", 45.0, 0.5)
	tween.tween_interval(1.0)
	tween.tween_property(parent, "scale", Vector2(1.0,1.0), 1.5)
	tween.tween_interval(1.5)
	tween.tween_property(parent, "rotation_degrees", 90.0, 3.5)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "scale", Vector2(0.9,0.9), 0.5)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 115.0, 1.5)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 120.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 180.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 150.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 37.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 270.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 215.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 105.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 90.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 75.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 60.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 30.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 15.0, 0.1)
	tween.tween_interval(0.5)
	tween.tween_property(parent, "rotation_degrees", 0.0, 0.1)
	tween.tween_interval(1.0)
	tween.tween_property(parent, "scale", Vector2(1.0,1.0), 1.5)
	

func offset_animation():
	
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	set_instance_shader_parameter("blur_amount", 10.0)
	#set_instance_shader_parameter("pixel_offset", 64.0)
	set_instance_shader_parameter("fixed_offset_vec2", Vector2(64.0, 0.0))
	
	tween.tween_method(shader_tween_method.bind("blur_amount"), 10.0, 0.0, 1.0)
	tween.chain().tween_interval(1.0)
	tween.chain().tween_method(shader_tween_method.bind("fixed_offset_vec2"), Vector2(64.0, 0.0), Vector2(0.0, 64.0), 0.5)
	#tween.tween_method(shader_tween_method.bind("pixel_offset"), 64.0, 0.0, 1.5)
	tween.chain().tween_interval(1.0)
	#tween.chain().tween_method(shader_tween_method.bind("pixel_offset"), 0.0, 128.0, 3.5)
	tween.chain().tween_method(shader_tween_method.bind("fixed_offset_vec2"), Vector2(0.0, 64.0), Vector2(128.0, 128.0), 0.5)
	tween.chain().tween_interval(0.5)
	tween.chain().tween_method(shader_tween_method.bind("fixed_offset_vec2"), Vector2(128.0, 128.0), Vector2(-48.0, 32.0), 1.5)
	tween.chain().tween_interval(0.5)
	tween.chain().tween_method(shader_tween_method.bind("fixed_offset_vec2"), Vector2(-48.0, 32.0), Vector2(256.0, 128.0), 0.5)
	tween.chain().tween_interval(0.5)
	tween.chain().tween_method(shader_tween_method.bind("fixed_offset_vec2"), Vector2(256.0, 128.0), Vector2(0.0, 0.0), 2.0)
	tween.chain().tween_method(shader_tween_method.bind("fixed_offset_vec2"), Vector2(0.0, 0.0), Vector2(16.0, 16.0), 2.0)
	tween.chain().tween_interval(0.25)
	tween.chain().tween_method(shader_tween_method.bind("fixed_offset_vec2"), Vector2(16.0, 16.0), Vector2(-64.0, 64.0), 2.0)

func _process(delta: float) -> void:
	time += delta #gotta be a variable for this...
	pass
	#parent.rotation += abs(sin(time)) * delta
	
	

func shader_tween_method(variable, parameter_name : String):
	set_instance_shader_parameter(parameter_name, variable)
	
