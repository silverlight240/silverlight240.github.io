extends Node2D
@export var slimesize = 1

func _on_timer_timeout() -> void:
	var slime 
	if slimesize == 1:
		slime = load("res://slime.tscn")
	if slimesize == 2:
		slime = load("res://BigSlime.tscn")
	if slimesize == 3:
		slime = load("res://Huge Slime.tscn")
	if slimesize == 4:
		slime = load("res://Queen Slime.tscn")
	var spawn = slime.instantiate()
	spawn.global_position = global_position
	get_parent().add_child(spawn)
	queue_free()
