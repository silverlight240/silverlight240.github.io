extends Area2D
#
@onready var root = get_parent().get_parent()
@onready var cave = $"../../Cave"
@onready var surface = get_parent()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.reparent(cave, true)
		if not cave.get_parent():
			root.add_child(cave)
		root.remove_child(surface)
