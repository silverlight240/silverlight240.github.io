extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and (body.form == "fly" or body.form == "bee") and $Pollen.visible:
		body.items.nectar += 1
		$Pollen.hide()
		$Timer.start()


func _on_timer_timeout() -> void:
	$Pollen.show()
