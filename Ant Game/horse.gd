extends CharacterBody2D
@onready var timer = $Timer
var direction = 1.0
const SPEED = 2000.0
const JUMP_VELOCITY = -400.0
@export var health = 100
func _ready() -> void:
	add_to_group("animal")
func _physics_process(delta: float) -> void:
	if health == 0:
		queue_free()
	if not is_on_floor():
		velocity += get_gravity() * delta
	if direction:
		velocity.x = direction * SPEED
	move_and_slide()
	if (not $Node2D70/RayCast2D.is_colliding()) or $Node2D70/RayCast2D2.is_colliding():
		direction *= -1
		$Node2D70.scale.x *= -1
		$StaticBody2D/CollisionPolygon2D.scale.x *= -1
		$StaticBody2D/CollisionPolygon2D.position.x *= -1
func _on_timer_timeout() -> void:
	modulate = Color(1,1,1,1)
