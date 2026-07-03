extends Sprite2D


# Called when the node enters the scene tree for the first time.




func _on_static_body_2d_body_entered(body: Node2D) -> void:
	scale.y = 0.8


func _on_static_body_2d_body_exited(body: Node2D) -> void:
	scale.y = 1
