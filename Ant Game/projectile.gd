extends CharacterBody2D

@export var target: Vector2
const SPEED = 1500.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	rotation_degrees = (target - global_position).normalized().angle()
	velocity = SPEED * (target - global_position).normalized()
func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not body.damaged:
		body.damaged = true
		if body.form == "bee" and body.nectar > 0:
			body.items.nectar -= 1
			body.scaley.modulate = Color(1,1,0,1)
			body.timer.start()
		else:
			body.health -= 1
			body.scaley.modulate = Color(1,1,1,0.25)
			body.timer.start()
			body.timer2.start()
	if not body.is_in_group("moth"):
		queue_free()
