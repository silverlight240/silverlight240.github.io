extends Node2D
var requier := 320
var flies := 0
func _ready() -> void:
	if SaveLoad.Load("bear") != null:
		var stats = SaveLoad.Load("bear")
		if stats["flies"] != null:
			flies = stats["flies"]
		if stats["requier"] != null:
			requier = stats["requier"]
# Called when the node enters the scene tree for the first time.
@onready var player = get_tree().get_first_node_in_group("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stats = {"requier": requier, "flies": flies}
	SaveLoad.contents["bear"] = stats
	$Button.text =  str(flies) + "/" + str(requier) + " " + "Grr. You know what to do."
	$ProgressBar.value = flies
	$ProgressBar.max_value = requier
	if flies >= requier:
		player.meats += 1
		flies -= requier
func _on_button_pressed() -> void:
	flies += player.flies 
	player.flies = 0
