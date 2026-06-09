extends CharacterBody2D
class_name Bullet
@export_group("Stats")
@export var Despawn:= true:
	set(value):
		Despawn = value
		notify_property_list_changed()
@export var Lifetime = 0.7
@export var aimlevel = 100.0
@export var pierce = 0.0
@export var speed = 700.0
var target: PathFollow2D
var direction
# Called when the node enters the scene tree for the first time.
func _validate_property(property: Dictionary) -> void:
	if property["name"] == &"Lifetime":
		if not Despawn:
			property.usage |= PROPERTY_USAGE_READ_ONLY
func _ready() -> void:
	$Timer.wait_time = Lifetime
	$Timer.start()
	if is_instance_valid(target):
		direction = (target.global_position - global_position).normalized()
		rotation = direction.angle() + (5 * (PI/180))
		velocity = direction * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction != null and target != null:
		direction += ((target.global_position - global_position).normalized()/ aimlevel)
	else:
		var distance = 0
		for i in get_tree().get_nodes_in_group("enemy"):
			if is_instance_valid(target):
				if global_position.distance_to(i.global_position) > global_position.distance_to(target.global_position):
					target = i.get_parent()
			else:
				target = i.get_parent()
	if direction:
		direction = direction.normalized()
		velocity = direction * speed
		rotation = direction.angle() + (5 * (PI/180))
	move_and_slide()




func _on_area_2d_body_entered(body: Node2D) -> void:
	body.health -= 1
	if pierce == 0:
		queue_free()
	else:
		pierce -= 1
		if is_instance_valid(target):
			$Timer.wait_time *= 1.75
			$Timer.start()


func _on_timer_timeout() -> void:
	if Despawn == true:
		queue_free()
