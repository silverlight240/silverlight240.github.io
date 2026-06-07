extends CharacterBody2D
class_name CatchableCreature
@export var giveamount = 1
@export var distance = 1000
var direction = Vector2()
@export var SPEED = 150.0
const JUMP_VELOCITY = -400.0
var trapped = false
@onready var player = get_tree().get_first_node_in_group("player")
func _physics_process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("player")
	if (not trapped) and player != null:
		direction = (player.global_position - global_position).normalized()
		if global_position.distance_to(player.global_position) < distance:
			velocity = direction * -SPEED
		else:
			velocity = Vector2(move_toward(velocity.x, 0,1),move_toward(velocity.y, 0,1))
		move_and_slide()
	elif trapped:
		$AnimatedSprite2D.stop()
