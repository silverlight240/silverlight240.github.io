extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button2.hide()
	$Button2.position = Vector2(99999999,99999999)
	if SaveLoad.contents != {"player": {"scale": Vector2(1,1), "flies": 0, "speed": 300, "zoom": Vector2(0.75,0.75), "spawntime": 4.00, "webs": 0}, "frog": {"flies": 0,"requirincrease": 4.0, "requier": 10, "speedincrease": 45}, "tadpole":{}, "spider": {}, "egg":{},}:
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
	}, "flies": 0, "speed": 300, "zoom":{"x": 0.75,"y": 0.75,}, "spawntime": 4.00, "webs": 0, "range":{"x": 91.0,"y": 96.0}}, "frog": {"flies": 0,"requirincrease": 4.0, "requier": 10, "speedincrease": 45}, "tadpole":{}, "spider": {}, "egg":{},}
	SaveLoad.save()


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
