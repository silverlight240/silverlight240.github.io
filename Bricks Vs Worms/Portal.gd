extends Area2D
@export var DestinationMarker: Marker2D
var working = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	working = true
	monitoring = false
	$Timer2.start()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if $AnimatedSprite2D.animation != "default":
			$Timer.start()
			$AnimatedSprite2D.play("default")
		if working:
			body.global_position = DestinationMarker.global_position


func _on_timer_2_timeout() -> void:
	monitoring = true
