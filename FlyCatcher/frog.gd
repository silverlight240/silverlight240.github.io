extends Node2D
var requier := 10
var speedincrease = 45
var flies := 0
var requirincrease = 4.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var stats
	stats = SaveLoad.Load("frog")
	flies = stats["flies"]
	speedincrease = stats["speedincrease"]
	requirincrease = stats["requirincrease"]
	requier = stats["requier"]
	print(SaveLoad.Load("frog"))
	add_to_group("frog")
	print(stats)
func LoadFromStats(x,z):
	var y
	y = z[str(x)]
	return y
@onready var player = get_tree().get_first_node_in_group("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stats = {"flies": flies,"requirincrease": requirincrease, "requier": requier, "speedincrease": speedincrease}
	SaveLoad.contents["frog"] = stats
	$Button.text =  str(flies) + "/" + str(requier) + " " + "Give Flies"
	$ProgressBar.value = flies
	$ProgressBar.max_value = requier
	if flies >= requier:
		player.speed += speedincrease
		flies -= requier
		speedincrease *= 1.3
		speedincrease += 10.0
		requier += requirincrease
		scale += Vector2(0.1,0.1)
		requirincrease += 0.15 * requirincrease
func _on_button_pressed() -> void:
	flies += player.flies 
	player.flies = 0
