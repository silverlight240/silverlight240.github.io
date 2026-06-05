extends CatchableCreature

func _ready() -> void:
	randomize()


func _exit_tree() -> void:
	for i in 5:
		var fly = load("res://tinyfly.tscn")
		var spawn = fly.instantiate()
		spawn.global_position = global_position + Vector2(randi_range(-50,50),randi_range(-50,50))
		get_parent().get_parent().add_child(spawn)
		fly = load("res://tinyfly.tscn")
		spawn = fly.instantiate()
		spawn.global_position = global_position + Vector2(randi_range(-50,50),randi_range(-50,50))
		get_parent().get_parent().add_child(spawn)
		fly = load("res://tinyfly.tscn")
		spawn = fly.instantiate()
		spawn.global_position = global_position + Vector2(randi_range(-50,500),randi_range(-50,50))
		get_parent().get_parent().add_child(spawn)
		fly = load("res://tinyfly.tscn")
		spawn = fly.instantiate()
		spawn.global_position = global_position + Vector2(randi_range(-50,500),randi_range(-50,50))
		get_parent().get_parent().add_child(spawn)
		fly = load("res://tinyfly.tscn")
		spawn = fly.instantiate()
		spawn.global_position = global_position + Vector2(randi_range(-50,500),randi_range(-50,50))
		get_parent().get_parent().add_child(spawn)
