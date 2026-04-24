extends Control

@export var logo : TextureRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_logo(toggle_on : bool):
	if toggle_on:
		logo.show()
	else:
		logo.hide()
