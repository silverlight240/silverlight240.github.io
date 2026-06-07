extends Node2D

var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("meat")
	print("alive!")
	player = get_tree().get_first_node_in_group("player")
	player.placedmeats.append({"x": global_position.x, "y": global_position.y})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
