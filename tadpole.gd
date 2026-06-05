extends Node2D
var requier := 22
var flies := 0
var requirincrease = 6.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("frog")

@onready var player = get_tree().get_first_node_in_group("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Button.text =  str(flies) + "/" + str(requier) + " " + "Give Flies"
	$ProgressBar.value = flies
	$ProgressBar.max_value = requier
	if flies >= requier:
		player.area2d.find_child("CollisionShape2D").shape.size += Vector2(15,15)
		player.scale += Vector2(0.2,0.2)
		player.camera.zoom = Vector2(1,1) / player.scale
		flies -= requier
		requier += requirincrease
		requirincrease += 0.25 * requirincrease
func _on_button_pressed() -> void:
	flies += player.flies 
	player.flies = 0
