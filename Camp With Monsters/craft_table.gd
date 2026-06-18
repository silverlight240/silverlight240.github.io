extends StaticBody2D
var hp = 0
@export var recipe: Recipe
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$ScrollContainer.show()
		if body.get_child(5).inventory.items[0].amount > (recipe.Require[0].QuantityWanted - 1):
			for i in $ScrollContainer/VBoxContainer.get_children():
				i.queue_free()
			$ScrollContainer/VBoxContainer.add_child(TextureButton.new())
			$ScrollContainer/VBoxContainer.get_child(0).texture_normal = recipe.item.texture
			$ScrollContainer/VBoxContainer.get_child(0).pressed.connect(on_button_pressed)
func on_button_pressed():
	get_tree().get_first_node_in_group("player").get_child(5).inventory.items[3] = recipe.item
	get_tree().get_first_node_in_group("player").get_child(5).inventory.items[0].amount -= recipe.Require[0].QuantityWanted
	$ScrollContainer/VBoxContainer.get_child(0).queue_free()
