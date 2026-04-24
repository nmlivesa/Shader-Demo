extends Control

@export var base_wave : Control
@export var wave_logo : Control
@export var swizzle_wave : Control
@export var swizzle_center_weighted : Control
@export var swizzle_duplicate : Control
@export var wave_lerped : Control
@export var add_logo : CheckBox
@export var wave_lerped_label : Label
@export var plane_wave : Control
@export var view3d : SubViewportContainer
@export var code_label : RichTextLabel

var index3d : int = 6
var current_shown
var shader_array : Array[Control]
var code_text_array : Array[String]

var base_wave_code : String = "void fragment() {
	vec2 uv = UV;
	float wave_height = sin(uv.x * (2.0 / wavelength) + TIME * speed) * amplitude  + 0.5 + y_offset;
	if (uv.y > wave_height) {
		COLOR = primary_color;
		if (use_uv_color) {
			COLOR = vec4(uv, 0.0,1.0);
		}
	}
	else {
		COLOR = secondary_color;
		if (use_uv_color) {
			COLOR = vec4(uv, 0.0,1.0);
		}
	}
	if (uv.y > wave_height - (highlight_size) / 2.0) if (uv.y < wave_height + (highlight_size) / 2.0) {
		COLOR = highlight_color;
	}
}"


func _ready() -> void:
	shader_array.append(base_wave)
	shader_array.append(wave_logo)
	shader_array.append(swizzle_wave)
	shader_array.append(swizzle_center_weighted)
	shader_array.append(swizzle_duplicate)
	shader_array.append(wave_lerped)
	shader_array.append(plane_wave)
	current_shown = shader_array.get(0)


func _on_option_button_item_selected(index: int) -> void:
	current_shown.hide()
	current_shown = shader_array.get(index)
	current_shown.show()
	
	if index >= index3d: 
		view3d.show()
	else:
		view3d.hide()
	if index == 5:
		wave_lerped_label.show()
		add_logo.show()
	else:
		wave_lerped_label.hide()
		add_logo.hide()

func _on_show_code_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on :
		code_label.show()
	else :
		code_label.hide()


func _on_add_logo_check_box_toggled(toggled_on: bool) -> void:
	wave_lerped.add_logo(toggled_on)
