extends RigidBody2D

var health = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	modulate = Color(randf_range(0.3,1),randf_range(0,0.7),randf_range(0,0.7),1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.health -= 1
