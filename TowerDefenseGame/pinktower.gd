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
		$Panel/Button3.hide()
		$Panel/Button4.show()


func _on_button_4_pressed() -> void:
	if playercontroller.cash >= 50:
		playercontroller.cash -= 50
		ShootTimes += 1
		$Timer.wait_time -= 0.25
		$Timer.start()
		$Panel/Button4.hide()
		$Panel/Button5.show()


func _on_button_5_pressed() -> void:
	if playercontroller.cash >= 50:
		playercontroller.cash -= 50
		ShootTimes += 2
		$Timer.wait_time -= 0.5
		$Timer.start()
		$Panel/Button5.hide()
