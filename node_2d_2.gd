extends Node2D
func _physics_process(delta: float) -> void:
	var acallback = Callable(self, "lose")  # define the Callable
	for node in get_tree().get_nodes_in_group("player"):
		if not node.is_connected("lose", acallback):
			node.connect("lose", acallback)

func _ready() -> void:
	visible = false
	var acallback = Callable(self, "lose")  
	for node in get_tree().get_nodes_in_group("player"):
		if not node.is_connected("lose", acallback):
			node.connect("lose", acallback)
func lose():
	visible = true
