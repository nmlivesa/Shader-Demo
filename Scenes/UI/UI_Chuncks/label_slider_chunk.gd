extends Control

signal new_value(variable_name : String, value: float)

@export var variable_name : String
@export var variable_display_name : String
@export var slider_min: float
@export var slider_max: float
@export var slider_start: float
@export var slider_step: float


@onready var label : Label = $VBoxContainer/Label
@onready var hslider : HSlider = $VBoxContainer/HSlider

var text : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	text = variable_display_name
	hslider.max_value = slider_max
	hslider.min_value = slider_min
	hslider.step = slider_step
	hslider.value = slider_start
	set_text(slider_start)



func set_text(value : float) :
	label.text = text + ": " + str(value)



func _on_h_slider_value_changed(value: float) -> void:
	set_text(value)
	new_value.emit(variable_name, value)
