extends Node2D
@export var spawn: PackedScene
@export var timee: float
@export var range: int
@export var health: int
func _ready() -> void:
	randomize()
	$Timer.wait_time = timee

func _on_timer_timeout() -> void:
	if get_tree().get_nodes_in_group("animal").size() < 100:
		var spawnthing2 = spawn.instantiate()
		spawnthing2.global_position = global_position + Vector2(randi_range(-range,range), randi_range(-range,range))
		spawnthing2.health = health
		get_parent().add_child(spawnthing2)
