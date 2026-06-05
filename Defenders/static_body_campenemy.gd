extends StaticBody2D
signal win2
var thingy11 = false
var hp = 10
var thingy15 = 70
var is_hit = false
var thingy12 : Node2D = null
var thingy4 = false
var average : float = 1
func _ready() -> void:
	randomize()
	add_to_group("enemy")
@onready var characterbody2d = preload("res://units/character_body_2denemyblock.tscn")
@onready var characterbody2slime = preload("res://units/character_body_2denemyslme.tscn")
var stuff = Vector2(
	randi() % 320 - 160,
	randi() % 320 - 160
)
signal spawn(average)

@onready var spawn_point: Marker2D = $Marker2D # Reference a spawn point node
func _on_timer_timeout() -> void:
	if thingy4 == false:
		thingy4 = true
	is_hit = false
	randomize()
	stuff = Vector2(
	randi() % 320 - 160,
	randi() % 320 - 160
	)
	if thingy15 >= 9: 
		thingy15 -= 1
	if randi() % thingy15 == 0:
		var new_object_instance = characterbody2slime.instantiate()
		get_parent().add_child(new_object_instance)
		new_object_instance.global_position = spawn_point.global_position + stuff
		if 0 >= hp :
			print("win")
			emit_signal("win2")
			queue_free()
	else:
		var new_object_instance = characterbody2d.instantiate()
		get_parent().add_child(new_object_instance)
		new_object_instance.global_position = spawn_point.global_position + stuff
		if 0 >= hp :
			print("win")
			emit_signal("win2")
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		thingy12 = body
		if thingy12 and thingy12.has_method("takedamage"):
			thingy12.takedamage()
func takedamage():
		if is_hit == false:
			hp -= 1
			is_hit = true
			$Timer2.start()
			print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
		if 0 >= hp :
			print("win")
			emit_signal("win2")
			queue_free()
func _on_timer_2_timeout() -> void:
	is_hit = false


func _on_timer_3_timeout() -> void:
	$Timer.start()
