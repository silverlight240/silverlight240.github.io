extends Area2D
var health = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health < 1:
		queue_free()
		get_tree().quit()
	$ProgressBar.value = health


func _on_body_entered(body: Node2D) -> void:
	body.get_parent().queue_free()
	health -= 1
