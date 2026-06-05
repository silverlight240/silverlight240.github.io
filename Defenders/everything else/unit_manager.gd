extends Node2D
var id = 0
signal sendID(id)
func _ready():
	for unit in get_tree().get_nodes_in_group("player"):
		unit.id = int(unit.get_instance_id()/1000)
		emit_signal("sendID", unit.id)
