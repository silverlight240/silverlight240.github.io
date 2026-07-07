extends DirectionalLight2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var surface = $"../Surface"
@onready var cave = $"../Cave"
@export var night = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
func _process(delta: float) -> void:
	if night and ($Timer.paused or $Timer.is_stopped()):
		if player.get_parent() == cave:
			$Timer.wait_time = 15
		if player.get_parent() == surface:
			$Timer.wait_time = 12
		$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_timer_timeout() -> void:
	var enemy: PackedScene = null
	if player.get_parent() == surface:
		enemy = load("res://slime.tscn")
	if player.get_parent() == cave:
		enemy = load("res://Living Rock.tscn")
	var spawn = enemy.instantiate()
	spawn.global_position = player.global_position + Vector2(randi_range(-2000,2000),randi_range(-2000,2000))
	while player.get_parent().get_child(0).get_cell_source_id(player.get_parent().get_child(0).local_to_map(spawn.global_position)) == -1:
		spawn.global_position = player.global_position + Vector2(randi_range(-2000,2000),randi_range(-2000,2000))
	player.get_parent().add_child(spawn)
