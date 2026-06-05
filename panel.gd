extends Panel
var thingy19 = true
var wood = 0
var thingy11 = true
var thingy9 = true
var thingy10 = false
var thingy6 = true
var thingy5 = true
var Berries = 10
var Seeds = 0
@onready var spawn_point: Marker2D = $Marker2D # Reference a spawn point node
var numberofstuff : int = 0
var hpratioofstuff : float = 0
@onready var camp = preload("res://everything else/camp.tscn")
@onready var bush = preload("res://everything else/bush.tscn")
@onready var barrier = preload("res://units/barrier.tscn")
var thingy3 = 0
signal create1(thingy3)
func _ready() -> void:
	add_to_group("thingy")
signal win()
signal hasBerries(Berries) 
signal origonal
func _process(delta: float) -> void:
	if thingy6 == false:
		$Label4.text = "You Have" + " " + str(wood) + " " + "Wood"
		$Label2.text = "You Have" + " " + str(Berries) + " " + "Berries"
		$Label3.text = "You Have" + " " + str(Seeds) + " " + "Seeds"
		emit_signal("hasBerries", Berries)
		emit_signal("create1", thingy3)
		$Marker2D.global_position = get_global_mouse_position()
		var callback = Callable(self, "selected")  # define the Callable
		for node in get_tree().get_nodes_in_group("player"):
			if not node.is_connected("select", callback):
				node.connect("select", callback)
		var acallback = Callable(self, "unselected")  # define the Callable
		for node in get_tree().get_nodes_in_group("player"):
			if not node.is_connected("unselect", acallback):
				node.connect("unselect", acallback)
		var ccallback = Callable(self, "spawn")  # define the Callable
		for node in get_tree().get_nodes_in_group("player"):
			if not node.is_connected("spawn", ccallback):
				node.connect("spawn", ccallback)
		var dcallback = Callable(self, "addBerries")  # define the Callable
		for node in get_tree().get_nodes_in_group("player"):
			if not node.is_connected("addBerries", dcallback):
				node.connect("addBerries", dcallback)
		var ecallback = Callable(self, "addSeed")  # define the Callable
		for node in get_tree().get_nodes_in_group("player"):
			if not node.is_connected("addSeed", ecallback):
				node.connect("addSeed", ecallback)
		var fecallback = Callable(self, "lose")  # define the Callable
		for node in get_tree().get_nodes_in_group("player"):
			if not node.is_connected("lose", fecallback):
				node.connect("lose", fecallback)
		var gcallback = Callable(self, "gainwood")  # define the Callable
		for node in get_tree().get_nodes_in_group("log"):
			if not node.is_connected("gainwood", gcallback):
				node.connect("gainwood", gcallback)
	else:
		var new_object_instance = camp.instantiate()
		get_parent().get_parent().get_parent().add_child(new_object_instance)
		new_object_instance.global_position = spawn_point.global_position 
		thingy3 = 1
		$Timer.start()
		if thingy6 == true:
			thingy6 = false
			thingy10 = true


func selected(maxhp):
	print (maxhp)
	numberofstuff += 1
	hpratioofstuff += maxhp
	if numberofstuff > 5:
		thingy3 = (round((hpratioofstuff / numberofstuff + (0.05 * (numberofstuff - 5))) * 100) / 100)
	else:
		thingy3 = hpratioofstuff / numberofstuff
		thingy3 = round(thingy3 * 100) / 100
	$Label.text = "You Have " + str(thingy3) + " Unit Average Hp"
func unselected(maxhp):
	print (maxhp)
	numberofstuff -= 1
	hpratioofstuff -= maxhp
	if numberofstuff > 5:
		thingy3 = (round((hpratioofstuff / numberofstuff + (0.05 * (numberofstuff - 5))) * 100) / 100)
	elif numberofstuff == 0:
		thingy3 = 0
		hpratioofstuff = 0
	else:
		thingy3 = hpratioofstuff / numberofstuff
		thingy3 = round(thingy3 * 100) / 100
	$Label.text = "You Have " +  str(thingy3) + " Unit Average Hp"
	if 0.0 >= thingy3:
		$Label.text = "You Have No Units"
	if 0.0 >= numberofstuff:
		$Label.text = "You Have No Units"
	if thingy3 == INF:
		"You Broke My Unit Average :<"
	if thingy3 >= 4:
		thingy3 = hpratioofstuff / numberofstuff
		if thingy3 >= 4:
			$Label.text = "Your Unit Average Is High"

signal create(thingy3)
func _on_button_pressed() -> void:
	if numberofstuff >= 5:
		$Label.text = "Select Building Spot"
		thingy5 = false
func _input(event):
	if thingy5 == false:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var new_object_instance = camp.instantiate()
			get_parent().get_parent().get_parent().add_child(new_object_instance)
			new_object_instance.global_position = spawn_point.global_position 
			$Timer.start()
			thingy5 = true
	if thingy9 == false:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var new_object_instance = bush.instantiate()
			get_parent().get_parent().get_parent().add_child(new_object_instance)
			new_object_instance.global_position = spawn_point.global_position 
			Seeds -= 1
			thingy9 = true
	if thingy19 == false:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var new_object_instance = barrier.instantiate()
			get_parent().get_parent().get_parent().add_child(new_object_instance)
			new_object_instance.global_position = spawn_point.global_position 
			wood -= 5
			thingy19 = true
func addBerries():
	Berries += 1
func addSeed():
	Seeds += 1
func _on_timer_timeout() -> void:
	emit_signal("create", thingy3)
	if numberofstuff > 0:
		thingy3 = hpratioofstuff / numberofstuff
		if numberofstuff > 5:
			thingy3 = (round((hpratioofstuff / numberofstuff + (0.05 * (numberofstuff - 5))) * 100) / 100)
		else:
			thingy3 = hpratioofstuff / numberofstuff
			thingy3 = round(thingy3 * 100) / 100
	else:
		thingy3 = 0
		if thingy10 == true:
			emit_signal("origonal")
			thingy10 = false
func spawn(average):
	Berries -= 1
	emit_signal("hasBerries", Berries)
	$Label2.text = "You Have" + " " + str(Berries) + " " + "Berries"


func _on_button_2_pressed() -> void:
	if Seeds >= 1:
		thingy9 = false
func lose():
	queue_free()
func gainwood():
	wood += 5
	$Label4.text = "You Have" + " " + str(wood) + " " + "Wood"

func _on_button_3_pressed() -> void:
	if Berries >= 40:
		Berries -= 40
		emit_signal("win")


func _on_button_5_pressed() -> void:
	if wood > 4:
		thingy19 = false
