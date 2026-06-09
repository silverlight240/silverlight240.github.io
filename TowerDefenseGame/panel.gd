extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if get_parent().cash > 4:
		get_parent().cash -= 5
		get_parent().lookingforclicks = true
		get_parent().spawnobject = "res://tower.tscn"

func _on_button_2_pressed() -> void:
	if get_parent().cash > 9:
		get_parent().cash -= 10
		get_parent().lookingforclicks = true
		get_parent().spawnobject = "res://short range tower.tscn"


func _on_button_3_pressed() -> void:
	if get_parent().cash > 4:
		get_parent().cash -= 5
		get_parent().lookingforclicks = true
		get_parent().spawnobject = "res://bluetower.tscn"
