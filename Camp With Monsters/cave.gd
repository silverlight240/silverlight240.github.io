extends Area2D

@onready var cave = $"../../Cave"
@onready var surface = get_parent()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.reparent(cave, true)
		surface.hide()
		cave.show()
