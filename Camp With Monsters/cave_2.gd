extends Area2D
@onready var root = get_parent().get_parent()
@onready var surface = $"../../Surface"
@onready var cave = get_parent()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.reparent(surface, true)
		root.remove_child(cave)
		if not surface.get_parent():
			root.add_child(surface)
