extends StaticBody2D
var hp = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Rock")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_parent().visible:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
	$ProgressBar.value = hp
