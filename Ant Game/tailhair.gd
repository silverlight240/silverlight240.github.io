extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var colorthig = randf_range(0,0.2)
	modulate = Color(0.85,0.8,colorthig + 0.65,1)
	rotation_degrees = randi_range(-10,10)
	$AnimationPlayer.speed_scale = randf_range(1,1.5)
