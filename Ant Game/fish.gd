extends CharacterBody2D
@export var health = 2
var direction = 1.0
const SPEED = 500.0
@onready var timer = $Timer
func _ready() -> void:
	add_to_group("fish")
	add_to_group("animal")
func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
	if $Node2D/RayCast2D2.is_colliding():
		$Node2D.scale.x *= -1
		direction *= -1
	velocity.x = SPEED * direction
	move_and_slide()


func _on_timer_timeout() -> void:
	modulate = Color(1,1,1,1)
