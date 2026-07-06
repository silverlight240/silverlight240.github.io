extends Node2D

var boody: Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.start()
		boody = body

func _on_timer_timeout() -> void:
	boody.zoom = false


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.form == "fly":
			boody = body
			$AnimationPlayer2.play("supertounge")
			$Timer2.start()


func _on_timer_2_timeout() -> void:
	boody.queue_free()
