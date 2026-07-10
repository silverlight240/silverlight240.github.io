extends CharacterBody2D
var was_on_floor = false
var jump = false
func _ready() -> void:
	add_to_group("player")
var speed = 300.0
var JUMP_VELOCITY = -600.0

var points = 0
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and $AnimatedSprite2D.animation != "Slide":
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and $AnimatedSprite2D.animation == "Slide" and $Timer.time_left < 0.35:
		jump = true
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.flip_h = false
		if direction < 0:
			$AnimatedSprite2D.flip_h = true
	else:
		if is_on_floor() and $AnimatedSprite2D.animation != "Slide":
			velocity.x = move_toward(velocity.x, 0, speed * 0.0325 * 0.5)
		if not is_on_floor():
			velocity.x -= 4
	move_and_slide()
	if is_on_floor() and not was_on_floor and Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("Slide")
		if $Timer.paused or $Timer.is_stopped() or $Timer.time_left == 1.25:
			$Timer.start()
		speed = 800
	if is_on_floor() and not was_on_floor:
		was_on_floor = true
	if not is_on_floor():
		was_on_floor = false

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("default")
	speed = 300
	if jump:
		jump = false
		JUMP_VELOCITY = -1000
		velocity.y = JUMP_VELOCITY
	JUMP_VELOCITY = -600


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Breakable") and (abs(velocity.x) > 300 or abs(velocity.y) > 600):
		body.queue_free()
