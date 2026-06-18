extends DirectionalLight2D
@export var night = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
func _process(delta: float) -> void:
	if night and ($Timer.paused or $Timer.is_stopped()):
		$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_timer_timeout() -> void:
	var enemy = load("res://slime.tscn")
	var spawn = enemy.instantiate()
	spawn.global_position = Vector2(randi_range(-2000,2000),randi_range(-2000,2000))
	get_parent().add_child(spawn)
