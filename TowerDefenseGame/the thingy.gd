extends Panel
@onready var playercontroller = get_tree().get_first_node_in_group("playercontroller")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	hide()


func _on_button_2_pressed() -> void:
	if playercontroller.cash > 2:
		playercontroller.cash -= 3
		$"../Bullet".scale += Vector2(0.2,0.2)
		$"../Bullet".particles.process_material.initial_velocity_min *= 1.2
		$"../Bullet".particles.process_material.initial_velocity_max *= 1.2
		$"../Bullet".particles.process_material.scale_min *= 1.2
		$"../Bullet".particles.process_material.scale_max *= 1.2
