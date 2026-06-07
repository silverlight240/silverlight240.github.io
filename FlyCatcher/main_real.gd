extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button2.hide()
	$Button2.position = Vector2(99999999,99999999)
	if SaveLoad.Load("player") != null and "flies" in SaveLoad.Load("player"):
		$Button2.show()
		$Button2.position = Vector2(277,15)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	SaveLoad.contents = {"player": {"scale": {
	"x": 1,
	"y": 1
	}, "meats": 0, "placedmeats": [],"placedwebs": [], "flies": 0.0, "speed": 550, "zoom":{"x": 0.75,"y": 0.75,}, "spawntime": 4.00, "webs": 0, "range":{"x": 91.0,"y": 96.0}}, "frog": {"flies": 0,"requirincrease": 4.0, "requier": 10, "speedincrease": 70}, "tadpole":{"requier": 22, "requirincrease": 6.5, "flies": 0}, "spider": {"requier": 70, "flies": 0}, "egg":{"requier":100,"flies":0,"requirething":100},"bear": {"requier": 320, "flies": 0}}
	SaveLoad.save()


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
