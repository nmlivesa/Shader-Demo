extends Control

@export var shader_rect : ColorRect

var mat : ShaderMaterial
func _ready() -> void:
	mat = shader_rect.material










func _on_color_picker_button_color_changed(color: Color) -> void:
	mat.set_shader_parameter("mix_color", color)



func _on_mix_baseline_new_value(variable_name: String, value: float) -> void:
	mat.set_shader_parameter(variable_name, value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		shader_rect.show()
	else:
		shader_rect.hide()


func _on_noise_step_new_value(variable_name: String, value: float) -> void:
	if mat:
		mat.set_shader_parameter(variable_name, value)


func _on_check_box_noise_toggled(toggled_on: bool) -> void:
	if toggled_on:
		mat.set_shader_parameter("random_multiplier", 0.01)
	else:
		mat.set_shader_parameter("random_multiplier", 0.00)
