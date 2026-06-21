extends Area2D

@onready var surface = $"../../Surface"
@onready var cave = get_parent()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.reparent(surface, true)
		surface.show()
		cave.hide()
