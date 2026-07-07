extends CharacterBody2D
@export var hp = 5
@export var SPEED = 250
@export var group = "Shadow"
@export var fliph = false
var currentstate: state = state.IDLE
enum state{IDLE,FOLLOWING,RUNNING_AWAY}
func _ready() -> void:
	add_to_group(group)
func _process(delta: float) -> void:
	$ProgressBar.value = hp
	var direction = (get_tree().get_first_node_in_group("player").global_position - global_position).normalized()
	if currentstate == state.FOLLOWING:
		velocity = direction * SPEED
		if fliph:
			if direction.x > 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			if direction.x > 0:
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.flip_h = true
	elif currentstate == state.RUNNING_AWAY:
		velocity = direction * (3 * -SPEED)
		$AnimatedSprite2D.position.y -= (1 * ($Timer.time_left - 0.125))
		$ProgressBar.position.y -= (1 * ($Timer.time_left - 0.125))
	if currentstate == state.IDLE:
		velocity = Vector2.ZERO
	move_and_slide()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		currentstate = state.FOLLOWING


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		currentstate = state.IDLE


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.health -= 1
		currentstate = state.RUNNING_AWAY
		$Timer.start()


func _on_timer_timeout() -> void:
	currentstate = state.FOLLOWING
	$AnimatedSprite2D.position.y = 0
	$ProgressBar.position.y = -119.0
