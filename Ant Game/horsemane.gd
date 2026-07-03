extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var colorthig = randf_range(0.1,0.4)
	modulate = Color(1.15,1.1,colorthig + 0.65,1)
	rotation_degrees = randi_range(-10,10)
	$AnimationPlayer.speed_scale = randf_range(1,1.5)
