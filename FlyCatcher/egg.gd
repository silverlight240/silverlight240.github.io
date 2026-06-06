extends Node2D
var requier := 100
var flies := 0
var requirething = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var stats = SaveLoad.Load("egg")
	requier = stats["requier"]
	flies = stats["flies"]
	requirething = stats["requirething"]
@onready var player = get_tree().get_first_node_in_group("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stats = {"requier":requier,"flies":flies,"requirething":requirething}
	SaveLoad.contents["egg"] = stats
	$Button.text =  str(flies) + "/" + str(requier) + " " + "..."
	$ProgressBar.value = flies
	$ProgressBar.max_value = requier
	if flies >= requier:
		player.spawner.timer.wait_time *= 0.875
		flies -= requier
func _on_button_pressed() -> void:
	flies += player.flies 
	player.flies = 0
