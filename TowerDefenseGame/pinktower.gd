extends Tower



func _on_button_pressed() -> void:
	$Panel.hide()
	$PointLight2D.hide()


func _on_button_2_pressed() -> void:
	if playercontroller.cash > 4:
		playercontroller.cash -= 5
		$CollisionShape2D.shape.radius += 30
		$Panel/Button2.hide()
		$Panel/Button3.show()


func _on_button_3_pressed() -> void:
	if playercontroller.cash >= 10:
		playercontroller.cash -= 10
		ShootTimes += 1
