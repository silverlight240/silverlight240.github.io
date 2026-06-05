extends StaticBody2D
var thingy12: Node2D = null
var arigonal = false
var canspawn = false
var thingy3 = 1
var is_hit = false
var hp = 10
var thingy4 = false
signal lose
var average : float = thingy3 
var thingy7 = false
func _ready() -> void:
	add_to_group("player")
	$Area2D.input_event.connect(_on_area_input_event)
	$Label.text = str(average)
	randomize()
	var acallback = Callable(self, "create")  # define the Callable
	for node in get_tree().get_nodes_in_group("thingy"):
		if not node.is_connected("create", acallback):
			node.connect("create", acallback)
	var bcallback = Callable(self, "create1")
	for node in get_tree().get_nodes_in_group("thingy"):
		if not node.is_connected("create1", bcallback):
			node.connect("create1", bcallback)
	var ccallback = Callable(self, "hasBerries")  # define the Callable
	for node in get_tree().get_nodes_in_group("thingy"):
		if not node.is_connected("hasBerries", ccallback):
			node.connect("hasBerries", ccallback)
	var dcallback = Callable(self, "origonal")  # define the Callable
	for node in get_tree().get_nodes_in_group("thingy"):
		if not node.is_connected("origonal", dcallback):
			node.connect("origonal", dcallback)
	add_to_group("camp")
	emit_signal("spawn", average)
func origonal():
	arigonal = true
func hasBerries(Berries):
	if Berries >= 1:
		canspawn = true
	else:
		canspawn = false
func create(thingy3: float) -> void:
	if thingy4 == false:
		average = thingy3
		thingy4 = true
		print("debuggystuff")
		$Label.text = str(average)
func create1(thingy3: float) -> void:
	if thingy4 == false:
		average = thingy3
		thingy4 = true
		print("debuggystuff")
		$Label.text = str(average)
@onready var characterbody2d = preload("res://units/character_body_2d.tscn")
var stuff = Vector2(
	randi() % 320 - 160,
	randi() % 320 - 160
)
signal spawn(average)
func _physics_process(delta: float) -> void:
	$Label.text = str(average)
	if average == 0:
		$Label.text = "L O A D I N G."
		thingy4 = false

@onready var spawn_point: Marker2D = $Marker2D # Reference a spawn point node
func _on_timer_timeout() -> void:
	$Label.text = str(average)
	if thingy4 == false:
		thingy4 = true
		average = 1.0
	if canspawn == true:
		is_hit = false
		randomize()
		stuff = Vector2(
		randi() % 320 - 160,
		randi() % 320 - 160
		)
		var new_object_instance = characterbody2d.instantiate()
		get_parent().add_child(new_object_instance)
		new_object_instance.global_position = spawn_point.global_position + stuff
		$Timer2.start()
func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		if arigonal == false:
			if thingy7 == false:
				for i in range(5):
					var stuff = Vector2(
						randi() % 320 - 160,
						randi() % 320 - 160
					)
					var new_unit = characterbody2d.instantiate()
					get_parent().add_child(new_unit)
					new_unit.global_position = spawn_point.global_position + stuff
					$Timer2.start()
					thingy7 = true
				queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		thingy12 = body
		if thingy12 and thingy12.has_method("takedamage"):
			thingy12.takedamage()
func takedamage():
	hp -=1
	$Timer3.start()
	is_hit = true
	if 0 >= hp :
		print("yay")
		queue_free()
		if arigonal == true:
			emit_signal("lose")
func _on_timer_2_timeout() -> void:
	emit_signal("spawn", average)
func _on_timer_3_timeout() -> void:
	is_hit = false
