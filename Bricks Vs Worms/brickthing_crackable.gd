extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_instance_valid($TileMapLayer):
		add_to_group("Breakable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
