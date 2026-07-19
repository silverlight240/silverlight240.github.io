extends Node2D
class_name Tile
@export var enemy: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Tile")
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func Loop():
	if randi_range(0,10) == 0:
		var spawn = enemy.instantiate()
		spawn.global_position = global_position + Vector2(25,85)
		get_parent().add_child(spawn)
