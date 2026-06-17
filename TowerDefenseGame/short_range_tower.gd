extends Tower
var pierceupgrade = false
var pierceupgrade2 = false
var autumn = false
# Called when the node enters the scene tree for the first time.

func spawn(x):
	for i in ShootTimes:
		var spawnbullet = projectile.instantiate()
		spacing = clamp(((spawnbullet.speed/3) / ShootTimes),30,999)
		if x == get_parent():
				if CareAboutEnemies:
					if pierceupgrade:
						spawnbullet.pierce = 3
						spawnbullet.aimlevel = 10
					if pierceupgrade2:
						spawnbullet.pierce = 36
					if autumn:
						spawnbullet.get_child(0).texture = load("res://autumnLeaf.png")
						spawnbullet.damage = 2.5
						spawnbullet.speed += 450
						spawnbullet.aimlevel = 0.01
						spawnbullet.pierce = -1
					if i > 0:
						spawnbullet.global_position = global_position
						spawnbullet.spawn_late = true
						spawnbullet.amount_of_lateness = 0.05 * i
					else:
						spawnbullet.global_position = global_position
		if CareAboutEnemies:
			spawnbullet.target = Bodey.get_parent()
		x.add_child(spawnbullet)

func _on_button_pressed() -> void:
	$Panel.hide()
	$PointLight2D.hide()


func _on_button_2_pressed() -> void:
	if playercontroller.cash >= 9:
		playercontroller.cash -= 9
		value += 9
		$Timer.wait_time = 0.15
		$Panel/Button2.hide()
		$Panel/Button3.show()


func _on_button_3_pressed() -> void:
	if playercontroller.cash >= 45:
		playercontroller.cash -= 45
		value += 45
		$Panel/Button3.hide()
		pierceupgrade = true
		$Panel/Button4.show()


func _on_button_4_pressed() -> void:
	if playercontroller.cash >= 320:
		playercontroller.cash -= 320
		value += 320
		pierceupgrade2 = true
		$Panel/Button4.hide()
		$Panel/Button5.show()


func _on_button_5_pressed() -> void:
	if playercontroller.cash >= 1000:
		playercontroller.cash -= 1000
		value += 1000
		autumn = true
		$Panel/Button5.hide()


func _on_button_6_pressed() -> void:
	playercontroller.cash += value
	queue_free()
