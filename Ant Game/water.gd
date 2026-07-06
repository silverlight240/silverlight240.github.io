extends Area2D
@export var waterabove = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("animal") or body.is_in_group("player"):
		if not body.is_in_group("fish"):
			body.health -= 1
		if body.is_in_group("player"):
			body.inwater = true
			if not body.is_in_group("fish"):
				body.timerr.start()
			if body.is_in_group("fish"):
				body.down = 0.5 * body.down





func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and body.global_position.y < global_position.y and not waterabove:
		body.timerr.stop()
		body.inwater = false
