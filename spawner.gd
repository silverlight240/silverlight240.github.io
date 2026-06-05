extends Node2D
var flys = ["res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://bee.tscn", "res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://bee.tscn","res://Have Baby.tscn","res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://bee.tscn", "res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://fly.tscn","res://fly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://tinyfly.tscn","res://bee.tscn","res://Have Baby.tscn","res://fairy.tscn"]
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var fly = load(flys.pick_random())
	var spawn = fly.instantiate()
	spawn.global_position = global_position + Vector2(randi_range(-750,750),randi_range(-750,750))
	get_parent().get_parent().add_child(spawn)
