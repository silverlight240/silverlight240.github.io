extends RigidBody2D
var exploding = false
var boyd
var scalething = 1
@export var direction: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Node2D.scale.x = abs($Node2D.scale.x) * scalething
	if not exploding:
		position.x += direction * 10
		position.y -= 1



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.health and not body.is_in_group("player"):
		boyd = body
		$AnimationPlayer.play("new_animation")
		exploding = true
		$Timer.start()


func _on_timer_timeout() -> void:
	if boyd != null:
		boyd.health -= 2
		queue_free()
