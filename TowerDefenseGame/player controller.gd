extends Node2D
var cash = 0
var spawnobject = "res://tower.tscn"
var lookingforclicks = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("playercontroller")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str(int(cash))
	if Input.is_action_just_pressed("mouseclik") and lookingforclicks:
		var canplace = true
		for tower in get_tree().get_nodes_in_group("tower"):
			if tower.global_position.distance_to(get_global_mouse_position()) >= 35:
				pass
			else:
				canplace = false
		if ($"../TileMapLayer".get_cell_source_id($"../TileMapLayer".local_to_map(get_global_mouse_position())) != -1) and canplace:
			var spawn = load(spawnobject)
			var spawnn = spawn.instantiate()
			spawnn.global_position = get_global_mouse_position()
			lookingforclicks = false
			spawnn.z_index = 2
			get_parent().add_child(spawnn)
