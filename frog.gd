extends Node2D
var requier := 10
var flies := 0
var requirincrease = 5.0
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
		player.speed += 45
		flies -= requier
		requier += requirincrease
		scale += Vector2(0.1,0.1)
		requirincrease += 0.25 * requirincrease
func _on_button_pressed() -> void:
	flies += player.flies 
	player.flies = 0
