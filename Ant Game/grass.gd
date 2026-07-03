extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	modulate = Color(randf_range(0.5,1.5),randf_range(0.5,1.5),randf_range(0.5,1.5),1)
	rotation_degrees = randi_range(-10,10)
	$AnimationPlayer.speed_scale = randf_range(1,1.5)
