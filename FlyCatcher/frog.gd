extends Node2D
var requier := 10
var speedincrease = 70
var flies := 0
var requirincrease = 4.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var stats = SaveLoad.Load("frog")
	if typeof(stats) != TYPE_DICTIONARY:
		stats = {}
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
		speedincrease *= 1.25
		speedincrease += 10
		requier += requirincrease
		requirincrease += 0.15 * requirincrease
func _on_button_pressed() -> void:
	flies += player.flies 
	player.flies = 0
