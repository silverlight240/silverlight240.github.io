extends Tower
var rangeupgrade2 = false
var spawned = true
var range_upgrade = false
var range_upgrade_3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if not is_instance_valid(get_child(4)) and not spawned:
		spawn(self)
		if range_upgrade:
			$"Bullet".scale += Vector2(0.2,0.2)
			$Bullet.particles.process_material.initial_velocity_min *= 1.2
			$Bullet.particles.process_material.initial_velocity_max *= 1.2
			$Bullet.particles.process_material.scale_min *= 1.2
			$Bullet.particles.process_material.scale_max *= 1.2
		if rangeupgrade2:
			$"Bullet".scale += Vector2(0.3,0.3)
			$Bullet.particles.process_material.initial_velocity_min *= 1.3
			$Bullet.particles.process_material.initial_velocity_max *= 1.3
			$Bullet.particles.process_material.scale_min *= 1.3
			$Bullet.particles.process_material.scale_max *= 1.3
		spawned = true


func _on_button_pressed() -> void:
	$Panel.hide()
	$PointLight2D.hide()


func _on_button_3_pressed() -> void:
	if playercontroller.cash > 249:
		playercontroller.cash -= 250
		value += 250
		$Bullet.scale += Vector2(0.3,0.3)
		$Bullet.particles.process_material.initial_velocity_min *= 1.3
		$Bullet.particles.process_material.initial_velocity_max *= 1.3
		$Bullet.particles.process_material.scale_min *= 1.3
		$Bullet.particles.process_material.scale_max *= 1.3
		rangeupgrade2 = true
		$Panel/Button3.hide()
		$Panel/Button4.show()

func _on_button_4_pressed() -> void:
	if playercontroller.cash > 499:
		playercontroller.cash -= 500
		value += 500
	$Bullet.scale += Vector2(0.3,0.3)
	$Bullet.particles.process_material.initial_velocity_min *= 1.3
	$Bullet.particles.process_material.initial_velocity_max *= 1.3
	$Bullet.particles.process_material.scale_min *= 1.3
	$Bullet.particles.process_material.scale_max *= 1.3
	range_upgrade_3 = true
	$Panel/Button4.hide()
	$Panel/Button5.show()


func _on_button_5_pressed() -> void:
	if playercontroller.cash > 999:
		playercontroller.cash -= 1000
		value += 1000
		var blackhole = load("res://blackhole.tscn")
		var spawn = blackhole.instantiate()
		spawn.global_position = global_position
		get_parent().add_child(spawn)
		queue_free()


func _on_button_6_pressed() -> void:
	playercontroller.cash += value
	queue_free()
