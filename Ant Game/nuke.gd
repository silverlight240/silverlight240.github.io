extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Exposiion.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("moth"):
		body.queue_free()
		$AnimationPlayer.play("expode")
		$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()
