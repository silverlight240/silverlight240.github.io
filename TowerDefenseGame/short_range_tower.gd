extends Tower


# Called when the node enters the scene tree for the first time.



func _on_button_pressed() -> void:
	$Panel.hide()


func _on_button_2_pressed() -> void:
	if playercontroller.cash >= 9:
		$Timer.wait_time = 0.3
		$Panel/Button2.hide()
