extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if is_instance_valid($"../CharacterBody2D") and $"../CharacterBody2D".is_in_group("player"):
		if direction == -1.0:
			$"../CharacterBody2D".scaley.scale = Vector2(-0.25, 0.25)
		if direction == 1.0:
			$"../CharacterBody2D".scaley.scale = Vector2(0.25, 0.25)
