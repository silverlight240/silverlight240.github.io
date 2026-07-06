extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$AnimationPlayer.speed_scale = randf_range(0.8,1.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
