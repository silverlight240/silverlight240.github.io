extends Node2D
var requier := 70
var flies := 0
# Called when the node enters the scene tree for the first time.
@onready var player = get_tree().get_first_node_in_group("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sceen = PackedScene.new()
	sceen.pack(self)
	SaveLoad.contents["spider"] = sceen
	$Button.text =  str(flies) + "/" + str(requier) + " " + "Give Flyyyyyeeesssssss"
	$ProgressBar.value = flies
	$ProgressBar.max_value = requier
	if flies >= requier:
		player.webs += 2
		flies -= requier
func _on_button_pressed() -> void:
	flies += player.flies 
	player.flies = 0
