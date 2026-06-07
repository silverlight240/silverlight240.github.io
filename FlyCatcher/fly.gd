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
		if get_tree().get_nodes_in_group("meat") != null:
			var avverage = Vector2()
			var thing = Vector2()
			var number: int
			for meat in get_tree().get_nodes_in_group("meat"):
				thing += meat.global_position 
				number += 1
			avverage = thing / number
			direction += 0.9 * -((avverage-global_position).normalized())
			direction = direction.normalized()
		if global_position.distance_to(player.global_position) < distance:
			velocity = direction * -SPEED
		else:
			velocity = Vector2(move_toward(velocity.x, 0,1),move_toward(velocity.y, 0,1))
		move_and_slide()
	elif trapped:
		$AnimatedSprite2D.stop()
