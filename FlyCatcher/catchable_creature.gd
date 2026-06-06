extends CatchableCreature

var Body



func _on_area_2d_body_entered(body: Node2D) -> void:
	if not trapped:
		$AnimatedSprite2D.play("new_animation")
		Body = body
		$Timer.start()


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("default")
	velocity = (global_position - Body.global_position).normalized() * -38000
	if Body in $Area2D.get_overlapping_bodies():
		Body.velocity = (global_position - Body.global_position).normalized() * 38000
		Body.move_and_slide()
		move_and_slide()
		$AnimatedSprite2D.play("default")
