extends ColorRect


#var point_array : Array[Vector2]
#var color_array : Array[Vector3]
var point_array : PackedVector2Array
var color_array : PackedVector3Array
var time : float = 0.0;
func _ready() -> void:
	for i in 1000:
		point_array.append(random_vector2())
		color_array.append(random_vector3())
	material.set_shader_parameter("point_array", point_array)
	material.set_shader_parameter("color_array", color_array)
	pass # Replace with function body.

func random_vector2() ->Vector2:
	return Vector2(randf_range(0.0,1.0),randf_range(0.0,1.0))

func random_vector3() ->Vector3:
	return Vector3(randf_range(0.0,1.0),randf_range(0.0,1.0),randf_range(0.0,1.0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#time += delta
	#point_array[0] = Vector2(sin(time), cos(time)) / 2.0 + Vector2(0.5,0.5)
	#material.set_shader_parameter("point_array", point_array)
