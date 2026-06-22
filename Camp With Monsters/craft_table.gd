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
		var thing: int = 0
		for recipe in recipes:
			if body.get_child(5).inventory.items[FindItem(recipe)] != null:
				if body.get_child(5).inventory.items[FindItem(recipe)].amount >= (recipe.Require[0].QuantityWanted):
					$ScrollContainer/VBoxContainer.add_child(TextureButton.new())
					$ScrollContainer/VBoxContainer.get_child(thing).texture_normal = recipe.item.texture
					$ScrollContainer/VBoxContainer.get_child(thing).pressed.connect(_on_button_pressed.bind(recipe))
					$ScrollContainer/VBoxContainer.get_child(thing).z_index = 9999
					thing += 1
func _on_button_pressed(recipe: Recipe):
	print(recipe)
	get_tree().get_first_node_in_group("player").DropItem(str(recipe.item.name),1)
	get_tree().get_first_node_in_group("player").get_child(5).inventory.items[FindItem(recipe)].amount -= recipe.Require[0].QuantityWanted
	if get_tree().get_first_node_in_group("player").get_child(5).inventory.items[FindItem(recipe)].amount < 1:
		get_tree().get_first_node_in_group("player").get_child(5).inventory.items[FindItem(recipe)] = null
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()
func FindItem(recipe):
			var thingeee: int = -1
			for i in get_tree().get_first_node_in_group("player").get_child(5).inventory.items:
				thingeee += 1
				if i != null:
					if i.name == recipe.Require[0].item.name:
						break
			return thingeee
func FindEmptySlot():
			var thingeee: int = -1
			for i in get_tree().get_first_node_in_group("player").get_child(5).inventory.items:
				thingeee += 1
				if i == null:
					break
			return thingeee
