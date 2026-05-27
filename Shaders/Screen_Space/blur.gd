extends ColorRect
@export var mix_target : float = 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween : Tween = create_tween()
	tween.tween_method(change_mix_value, 0.5, mix_target, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func change_mix_value(amount : float) :
	pass
	material.set_shader_parameter("mix_amount", amount)
