extends CharacterBody2D
@export var SPEED = 200
@export var hp = 2
enum state{IDLE,FOLLOWING,RUNNING_AWAY}
var CurrentState: state = state.IDLE
#
func _ready() -> void:
	add_to_group("slime")
	add_to_group("Hugeslime")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.get_parent() == get_parent():
		$Timer.stop()
		CurrentState = state.FOLLOWING
func _process(delta: float) -> void:
	if hp <= 0:
		queue_free()
	$ProgressBar.value = hp
	var direction = (get_tree().get_first_node_in_group("player").global_position - global_position).normalized()
	if CurrentState == state.IDLE:
		$AnimatedSprite2D.play("default")
		direction = Vector2.ZERO
	if CurrentState == state.FOLLOWING:
		$AnimatedSprite2D.play("Jump")
	$AnimatedSprite2D.flip_h = false
	if CurrentState == state.FOLLOWING:
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
	if CurrentState == state.FOLLOWING:
		velocity = direction * SPEED
	if CurrentState == state.RUNNING_AWAY:
		velocity = direction * (2 * -SPEED)
		$AnimatedSprite2D.position.y -= (3 * ($Timer2.time_left - 0.125))
		$ProgressBar.position.y -= (3 * ($Timer2.time_left - 0.125))
	move_and_slide()




func _on_timer_timeout() -> void:
	CurrentState = state.IDLE


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body != self and body.is_in_group("Hugeslime"):
		body.queue_free()
		var spawn = load("res://Enormous Pod.tscn").instantiate()
		spawn.global_position = global_position
		get_parent().add_child(spawn)
		queue_free()
	if body != self and body.is_in_group("player") and body.get_parent() == get_parent():
		body.health -= 1
		CurrentState = state.RUNNING_AWAY
		$Timer2.start()
		$AnimatedSprite2D.speed_scale = 0.2


func _on_area_2d_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.start()


func _on_timer_2_timeout() -> void:
	CurrentState = state.FOLLOWING
	$AnimatedSprite2D.speed_scale = 1
	$AnimatedSprite2D.position.y = 0
	$ProgressBar.position.y = -45
