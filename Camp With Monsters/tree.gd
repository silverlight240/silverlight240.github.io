extends StaticBody2D

var hp = 5
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = hp
	add_to_group("tree")
	if get_parent().visible:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
