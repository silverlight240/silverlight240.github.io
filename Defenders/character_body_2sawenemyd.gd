extends CharacterBody2D
func _ready():
	randomize()
	add_to_group("enemy")
var hp = 9+ (randf() * 2.5 - 1.25)
var is_hit = false
var lookaround = false

var thingy1 = 1
var thingy2 = 480
var max_speed =100





func _physics_process(delta: float) -> void:
	move_and_slide()
	if $RayCast2D.is_colliding():
		var direction = $RayCast2D.get_collision_point()  - global_position
		var vel = direction
		if vel.length() > max_speed:
			vel = vel.normalized() * max_speed
		velocity = vel
		move_and_slide()
	else:
		if lookaround == true:
			if $RayCast2D.is_colliding():
				var direction = $RayCast2D.get_collision_point()  - global_position
				var vel = direction
				if vel.length() > max_speed:
					vel = vel.normalized() * max_speed
				velocity = vel
				move_and_slide()
			if 360 >= thingy2 :
				lookaround = false
			if thingy2 > 360 :
				if thingy2 < 480 :
					lookaround = true
			if 481 == thingy2:
				thingy2 = 0
			if 30 > thingy1 :
				rotation_degrees += 3
				thingy1 += 1 
				position.y += 1
				thingy2 += 1 
			if 29 < thingy1 :
				if 90 >= thingy1 :
					rotation_degrees -= 3
					thingy1 += 1
					position.y += 1
					thingy2 += 1 
			if 89 < thingy1 :
				if 120 > thingy1 :
					rotation_degrees += 3
					thingy1 += 1 
					thingy2 += 1 
					position.y += 1
			if 120 == thingy1 :
				thingy1 = 0
				rotation_degrees -= 6
				position.y += 1
		else:
			if $RayCast2D.is_colliding():
				var direction = $RayCast2D.get_collision_point()  - global_position
				var vel = direction
				if vel.length() > max_speed:
					vel = vel.normalized() * max_speed
				velocity = vel
				move_and_slide()
			thingy2 += 1 
			if 360 >= thingy2 :
				position.y += 1
				lookaround = false
			if thingy2 > 360 :
				if thingy2 < 480 :
					position.y += 1
					lookaround = true
			if 481 == thingy2:
				position.y += 1
				thingy2 = 0
	if $RayCast2D.is_colliding():
		var direction = $RayCast2D.get_collision_point()  - global_position
		var vel = direction
		if vel.length() > max_speed:
			vel = vel.normalized() * max_speed
		velocity = vel
		move_and_slide()
func _on_timer_timeout() -> void:
	is_hit = false

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	var direction = body.global_position - global_position
	if body.is_in_group("player"):
		if is_hit == false:
			hp -= 1
			if $RayCast2D.is_colliding():
				direction = global_position - $RayCast2D.get_collision_point() 
				var vel = direction
				vel = vel.normalized() *(max_speed *30)
				velocity = vel
				move_and_slide()
			$Timer.start()
			is_hit = true
		if 1 > hp :
			print("yay")
			queue_free()
