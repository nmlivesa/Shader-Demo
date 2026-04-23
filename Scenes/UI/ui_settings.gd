extends PanelContainer

@export var amplitude_label : Label
@export var amplitude_slider : HSlider
var amplitude_text : String = "Amplitude: "

@export var speed_label : Label
@export var speed_slider : HSlider
var speed_text : String = "Speed: "

@export var x_offset_label : Label
@export var x_offset_slider : HSlider
var x_offset_text : String = "X Offset: "

@export var y_offset_label : Label
@export var y_offset_slider : HSlider
var y_offset_text : String = "Y Offset: "

@export var wavelength_label : Label
@export var wavelength_slider : HSlider
var wavelength_text : String = "Wavelength: "

@export var highlight_size_label : Label
@export var highlight_size_slider : HSlider
var highlight_size_text : String = "Wave Size: "


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_labels(amplitude_label, amplitude_text, amplitude_slider)
	setup_labels(speed_label, speed_text, speed_slider)
	setup_labels(x_offset_label, x_offset_text, x_offset_slider)
	setup_labels(y_offset_label, y_offset_text, y_offset_slider)
	setup_labels(wavelength_label, wavelength_text, wavelength_slider)
	setup_labels(highlight_size_label, highlight_size_text, highlight_size_slider)
	



func  setup_labels(label : Label, text: String, slider : HSlider) :
	label.text = text + str(slider.value)

func set_label(label : Label, text: String, value: float) :
	label.text = text + str(value)

func _on_h_slider_amplitude_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("amplitude", value)
	amplitude_label.text = amplitude_text + str(value)

func _on_h_slider_speed_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("speed", value)
	speed_label.text = speed_text + str(value)

func _on_h_slider_x_offset_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("x_offset", value)
	x_offset_label.text = x_offset_text + str(value)

func _on_h_slider_y_offset_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("y_offset", value)
	y_offset_label.text = y_offset_text + str(value)

func _on_h_slider_wavelength_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("wavelength", value)
	wavelength_label.text = wavelength_text + str(value)

func _on_h_slider_wave_size_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("highlight_size", value)
	highlight_size_label.text = highlight_size_text + str(value)


func _on_uv_check_box_toggled(toggled_on: bool) -> void:
	RenderingServer.global_shader_parameter_set("use_uv_color", toggled_on)
