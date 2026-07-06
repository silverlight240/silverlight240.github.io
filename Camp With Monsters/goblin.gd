extends CharacterBody2D
const SPEED = 250
var hp = 6
enum state{IDLE,FOLLOWING}
var CurrentState: state = state.IDLE
#
func _ready() -> void:
	add_to_group("slime")
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
		direction = Vector2.ZERO
	velocity = direction * SPEED
	move_and_slide()




func _on_timer_timeout() -> void:
	CurrentState = state.IDLE


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body != self and body.is_in_group("player") and body.get_parent() == get_parent():
		body.health -= 1


func _on_area_2d_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.start()
