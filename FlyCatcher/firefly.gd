extends CatchableCreature


func _ready() -> void:
	randomize()
	add_to_group("firefly")

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	var average = Vector2()
	var number: int
	var thing = Vector2()
	for firefly in get_tree().get_nodes_in_group("firefly"):
		if global_position.distance_to(firefly.global_position) < 250 and firefly != self:
			thing += firefly.global_position
			number += 1
	average = thing / number
	if global_position.distance_to(average) > randi_range(70,130):
		direction = (average - global_position).normalized()
		direction = direction.normalized()
	velocity = direction * 0.4 * SPEED
	move_and_slide()
