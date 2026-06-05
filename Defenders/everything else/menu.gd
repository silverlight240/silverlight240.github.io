extends Node2D
func _ready() -> void:
	$Label.hide()
	
func _on_button_pressed() -> void:
	Global.gamemode = 1
	get_tree().change_scene_to_file("res://everything else/main.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_button_3_pressed() -> void:
	$Label.show()
	$Control.hide()


func _on_a_pressed() -> void:
	get_tree().change_scene_to_file("res://everything else/menu.tscn")
