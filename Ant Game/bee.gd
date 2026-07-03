extends CharacterBody2D
@export var health: int
var direction = Vector2()
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	randomize()
func _physics_process(delta: float) -> void:
	if $Node2D/RayCast2D.is_colliding():
		direction += Vector2((scale.x * randf_range(-0.02,0.1)), 0.03)
	if not is_on_floor():
		velocity = direction * SPEED
	if is_on_floor():
		velocity.y = -0.01 * SPEED
		velocity.x = -20 * scale.x
	if is_on_ceiling():
		velocity.y = 0.01 * SPEED
	move_and_slide()



func _on_timer_timeout() -> void:
	direction -= Vector2(0.05, 0.05)
	velocity.y -= 30
	direction += Vector2(randf_range(-1,1), randf_range(-1,1))
	if direction.x < 0:
		$Node2D.scale.x = -1
	if direction.x > 0:
		$Node2D.scale.x = 1
