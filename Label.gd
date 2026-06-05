extends Node2D
func _physics_process(delta: float) -> void:
	var acallback = Callable(self, "win2")  # define the Callable
	for node in get_tree().get_nodes_in_group("enemy"):
		if not node.is_connected("win2", acallback):
			node.connect("win2", acallback)
	var callback = Callable(self, "win")  
	for node in get_tree().get_nodes_in_group("thingy"):
		if not node.is_connected("win", callback):
			node.connect("win", callback)
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var enimated_sprite: AnimatedSprite2D = $AnimatedSprite2D2
func _ready() -> void:
	visible = false
	var acallback = Callable(self, "win")  
	for node in get_tree().get_nodes_in_group("enemy"):
		if not node.is_connected("win", acallback):
			node.connect("win", acallback)
	var callback = Callable(self, "win")  
	for node in get_tree().get_nodes_in_group("thingy"):
		if not node.is_connected("win2", callback):
			node.connect("win2", callback)
func win():
	visible = true
	enimated_sprite.play("defaultt")
func win2():
	visible = true
	enimated_sprite.play("default")
	enimated_sprite.position.x -= 100
