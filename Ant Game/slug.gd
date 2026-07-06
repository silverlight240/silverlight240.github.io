extends CharacterBody2D
@export var health: int
var turn = true
var direction = -1
const SPEED = -100.0
const JUMP_VELOCITY = -400.0
@onready var timer = $Timer

func _physics_process(delta: float) -> void:
	var color = $Node.modulate
	$Node.modulate += Color(randf_range(0,0.05),randf_range(0,0.05),randf_range(0,0.05))
	if ((color.r + color.g + color.b) / 3.0) > 2 or ((color.r + color.g + color.b) / 3.0) < 0:
		$Node.modulate -= Color(0.5,0.5,0.5)
	if health <= 0:
		queue_free()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.play("move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.stop()
	if ($Node/RayCast2D.is_colliding() or not $Node/RayCast2D2.is_colliding()) and turn:
		direction = direction * -1
		$Node.scale.x *= -1
		$Area2D.scale.x *= -1
	move_and_slide()
func _ready() -> void:
	add_to_group("animal")
	randomize()
	scale.x = randf_range(0.8,1.2)
	scale.y = scale.x




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not body.damaged and body.form != "slug":
		if body.form == "bee" and body.nectar > 1:
			body.items.nectar -= 2
			body.scaley.modulate = Color(1,1,0,1)
		else:
			body.health -= 2
			body.progressbar.value = 0
			body.scaley.modulate = Color(1,1,1,0.25)
		body.timer.start()


func _on_timer_timeout() -> void:
	modulate = Color(1,1,1,1)
	var color = $Node.modulate
	$Node.modulate += Color(randf_range(0,0.5),randf_range(0,0.5),randf_range(0,0.5))
	if ((color.r + color.g + color.b) / 3.0) > 1 or ((color.r + color.g + color.b) / 3.0) < 0:
		$Node.modulate = Color(0.5,0.5,0.5)
	print($Node.modulate)
