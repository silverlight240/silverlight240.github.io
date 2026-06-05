extends CharacterBody2D
func _ready():
	$Area2D.input_event.connect(_on_area_input_event)
	add_to_group("player")
	randomize()
var hp = 9 + (randf() * 2.5 - 1.25)
var is_hit = false
var thingy = false
var max_speed := 300
signal select(hp)
signal unselect(hp)
func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		thingy = true
		emit_signal("select", hp)
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		thingy = false
		emit_signal("unselect", hp)

func _physics_process(delta: float) -> void:
	if 1 > hp :
		print("yay")
		queue_free()
	if thingy:
		var direction = get_global_mouse_position() - global_position
		rotation = direction.angle() + deg_to_rad(90)
		var vel = direction
		if vel.length() > max_speed:
			vel = vel.normalized() * max_speed
		velocity = vel
		move_and_slide()
	else:
		rotation_degrees += 4.5
		if $RayCast2D.is_colliding():
			var direction = $RayCast2D.get_collision_point()  - global_position
			var vel = direction
			if vel.length() > max_speed:
				vel = vel.normalized() * max_speed
			velocity = vel
			move_and_slide()
			rotation_degrees -= 4.5
func _on_timer_timeout() -> void:
	is_hit = false
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("enemy"):
		if is_hit == false:
			hp -= 1
			if $RayCast2D.is_colliding():
				var direction = global_position - $RayCast2D.get_collision_point() 
				var vel = direction
				vel = vel.normalized() *(max_speed *20)
				rotation_degrees = 0
				velocity = vel
				move_and_slide()
			$Timer.start()
			is_hit = true
		if 1 > hp :
			print("yay")
			queue_free()
