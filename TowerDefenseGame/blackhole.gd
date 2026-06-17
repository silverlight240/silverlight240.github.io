extends Bullet

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.health -= damage




func _on_area_2d_2_body_entered(body: Node2D) -> void:
	body.speed = $"../Path2D".curve.get_closest_offset($"../Path2D".to_local((global_position - body.global_position).normalized() * 15)) - 50


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	body.speed = body.DefaultSpeed
