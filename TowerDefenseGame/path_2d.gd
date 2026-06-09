extends Path2D
@export var enemy: PackedScene
var wave = 1
var spawns = 3
var health = 3.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = "Wave " + str(wave)


func _on_timer_timeout() -> void:
	print(spawns)
	$Timer.stop()
	if spawns > 0:
		var spawn = enemy.instantiate()
		spawn.global_position = global_position
		spawn.get_child(0).health = health
		add_child(spawn)
		spawns -= 1
	else:
		$Timer.wait_time = clamp((4 - wave/3),0.2,6)
		wave += 1
		spawns = 3 + (wave-1)
		health = 3 + ((wave - 1) * 0.5)
		health *= 1.15
	$Timer.start()
