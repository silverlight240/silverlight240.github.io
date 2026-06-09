extends VSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if value > 0:
		Engine.time_scale = clamp(value,0.25,5)
	elif value < 0:
		Engine.time_scale = clamp((abs(value) / abs(value)) / abs(value),0.25,5)

func _on_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
