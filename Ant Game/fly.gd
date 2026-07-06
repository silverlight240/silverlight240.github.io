extends CharacterBody2D
var c = true
var origonal = 1.0
@onready var timer = $Timer2
var direction = 1
@export var health: int
func _ready() -> void: 
	add_to_group("animal")
	randomize()
	$AnimationPlayer.speed_scale = randf_range(1,2)
	origonal = $AnimationPlayer.speed_scale
	$Timer.wait_time = randf_range(3.5,4.5)
func _on_timer_timeout() -> void:
	direction *= -1
func _physics_process(delta: float) -> void:
	if direction < -0.1:
		$AnimationPlayer.speed_scale = 2 * origonal
	elif direction > 0.1:
		$AnimationPlayer.speed_scale = 1 * origonal
	if health <= 0:
		queue_free()
	velocity.y = direction * 400
	if (is_on_floor() or is_on_ceiling()) and c:
		direction *= -1
		$Timer.start()
		$Timer3.start()
		c = false
	move_and_slide()

func _on_timer_2_timeout() -> void:
	modulate = Color(1,1,1,1)


func _on_timer_3_timeout() -> void:
	c = true
