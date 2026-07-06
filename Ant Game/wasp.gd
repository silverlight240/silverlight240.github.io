extends CharacterBody2D
@onready var timer = $Timer2
var direction = 1
var c = false
var origonal = 1.0
@export var health: int
func _physics_process(delta: float) -> void:
	if direction < -0.1:
		$AnimationPlayer.speed_scale = 2 * origonal
	elif direction > 0.1:
		$AnimationPlayer.speed_scale = 1 * origonal
	if (is_on_floor() or is_on_ceiling()) and c:
		direction *= -1
		$Timer.start()
		$Timer3.start()
		c = false
	velocity = Vector2(0,0)
	if health <= 0:
		queue_free()
	if $RayCast2D.is_colliding():
		velocity = (($RayCast2D.get_collision_point() - global_position).normalized() * 400)
	else:
		velocity.y = direction * 1200
	move_and_slide()
func _ready() -> void: 
	add_to_group("animal")
	randomize()
	$AnimationPlayer.speed_scale = randf_range(1,2)
	origonal = $AnimationPlayer.speed_scale
	$Timer.wait_time = randf_range(3.5,4.5)
func _on_timer_timeout() -> void:
	direction *= -1


func _on_timer_2_timeout() -> void:
	modulate = Color(1,1,1,1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not "wasp" in body.forms:
		if body.form == "bee" and body.nectar > 0:
			body.items.nectar -= 1
			body.scaley.modulate = Color(1,1,0,1)
		else:
			body.health -= 1
			body.progressbar.value = 0
			body.scaley.modulate = Color(1,1,1,0.25)
		body.timer.start()
		velocity.x = 15000 
		move_and_slide()
		move_and_slide()
		move_and_slide()
	if body.is_in_group("animal") and not body == self:
		body.health -= 1
		body.modulate = Color(200,200,200,1)
		body.timer.start()
		velocity.x = 15000
		move_and_slide()
		move_and_slide()
		move_and_slide()



func _on_timer_3_timeout() -> void:
	c = true


func _on_timer_4_timeout() -> void:
	scale.x *= -1 
