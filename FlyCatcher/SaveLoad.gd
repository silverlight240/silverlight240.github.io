extends Node
var loadwebs = true
const SAVELOCATION = "user://SaveFile.json"
var contents: Dictionary = {"player": {}, "frog": {}, "tadpole":{}, "spider": {}, "egg":{},}
var webs:= []
func save():
	print("sove")
	var file = FileAccess.open(SAVELOCATION,FileAccess.WRITE)
	file.store_string(JSON.stringify(contents))
	file.close()
func Load(x):
	if FileAccess.file_exists(str(SAVELOCATION)):
		var file = FileAccess.open(SAVELOCATION,FileAccess.READ)
		var text = file.get_as_text()
		file.close()
		var save_data = JSON.parse_string(text)
		contents = Dictionary(save_data)
		return save_data[str(x)]
	if webs.size() > 0 and loadwebs:
		for web in webs:
			var webb = load("res://cobwebtrap.tscn").instantiate()
			webb.global_position = web
			get_parent().add_child(webb)
		loadwebs = false
		webs.clear()

func _on_timer_timeout() -> void:
	save()
