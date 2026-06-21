extends StaticBody2D
var hp = 0
@export var recipes: Array[Recipe]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		for i in $ScrollContainer/VBoxContainer.get_children():
			i.queue_free()
		$ScrollContainer.show()
		var thing = 0
		for recipe in recipes:
			print(recipe)
			if body.get_child(5).inventory.items[0].amount > (recipe.Require[0].QuantityWanted - 1):
				print("this part works")
				$ScrollContainer/VBoxContainer.add_child(TextureButton.new())
				$ScrollContainer/VBoxContainer.get_child(thing).texture_normal = recipe.item.texture
				$ScrollContainer/VBoxContainer.get_child(thing).pressed.connect(on_button_pressed.bind(recipe))
				thing += 1
func on_button_pressed(recipe: Recipe):
	get_tree().get_first_node_in_group("player").get_child(5).inventory.items.append(recipe.item)
	get_tree().get_first_node_in_group("player").get_child(5).inventory.items[0].amount -= recipe.Require[0].QuantityWanted
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()
