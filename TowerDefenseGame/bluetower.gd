extends Tower
var spawned = true
var range_upgrade = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if not is_instance_valid(get_child(2)) and not spawned:
		spawn(self)
		if range_upgrade:
			$"Bullet".scale += Vector2(0.2,0.2)
			$Bullet.particles.process_material.initial_velocity_min *= 1.2
			$Bullet.particles.process_material.initial_velocity_max *= 1.2
			$Bullet.particles.process_material.scale_min *= 1.2
			$Bullet.particles.process_material.scale_max *= 1.2
		spawned = true


func _on_button_pressed() -> void:
	$Panel.hide()
	$PointLight2D.hide()
