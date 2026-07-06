extends CharacterBody2D
@export var health: int
var turn = true
var direction = -1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var timer = $Timer2

func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
	if not is_on_floor():
		velocity += get_gravity() * delta
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.stop()
	if ($Node/RayCast2D.is_colliding() or not $Node/RayCast2D2.is_colliding()) and turn:
		direction = direction * -1
		$Node.scale.x *= -1
		$CollisionPolygon2D.scale.x *= -1
		$CollisionShape2D.scale.x *= -1
		$Area2D.scale.x *= -1
		turn = false
		$Timer.start()
	move_and_slide()
func _ready() -> void:
	add_to_group("animal")

func _on_timer_timeout() -> void:
	turn = true


func _on_area_2d_body_entered(body: Node2D) -> void: 
	if body.is_in_group("player"): 
		if body.form == "bee" and body.nectar > 0:
			body.nectar -= 1
			body.scaley.modulate = Color(1,1,0,1)
		else:
			body.progressbar.value = 0
			body.scaley.modulate = Color(1,1,1,0.25)
		body.timer.start()


func _on_timer_2_timeout() -> void:
	modulate = Color(1,1,1,1)
