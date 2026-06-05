extends CharacterBody2D
func _enter_tree() -> void:
	$Area2D.input_event.connect(_on_area_input_event)
	add_to_group("player")
	randomize()
	var bcallback = Callable(self, "spawn")
	for node in get_tree().get_nodes_in_group("player"):
		if not node.is_connected("spawn", bcallback):
			node.connect("spawn", bcallback)
	var dcallback = Callable(self, "win")  # define the Callable
	for node in get_tree().get_nodes_in_group("enemy"):
		if not node.is_connected("win", dcallback):
			node.connect("win", dcallback)
var thingy14 = false
var thingy12: Node2D = null
var thingy13 = false
@onready var spawn_point: Marker2D = $Marker2D # Reference a spawn point node
@onready var spawnguy2 = preload("res://units/character_body_2d2.tscn")
@onready var spawnguy1 = preload("res://units/BERRYGUY.tscn")
var exp = 0
var berryxp = 9
var marker2dthingy : Node2D = null
var marker2dthingy2 : Node2D = null
var maxhp = 3 + (randf() * 1 - 0.4)
var hp = maxhp
var is_hit = false
var thingy = false
var max_speed := 300
var hasaverage = false
var hpaverage = 0.0
var thingy15 = false
var pointtowards = 0
func spawn(average: float) -> void:
	if hasaverage == false:
		hpaverage = average
		hasaverage = true
		print("OKEE")
		maxhp = hpaverage + (randf() * 0.5 - 0.25)
		hp = maxhp
func gainexp():
	exp += 1
	hp = maxhp
	self.modulate = Color.YELLOW
	if exp >= 3:
		$Timer2.start()
		self.modulate = Color.GRAY
		thingy13 = true
		if thingy == true:
			thingy = false
			emit_signal("unselect", maxhp)



signal select(maxhp)
signal unselect(maxhp)


func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if thingy == false:
			emit_signal("select", maxhp)
			thingy = true
		if thingy == true:
			thingy14 = false
			thingy15 = false
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		if thingy == true:
			thingy = false
			emit_signal("unselect", maxhp)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE:
		if thingy == true:
			if thingy14 == false:
				thingy14 = true
				if not marker2dthingy:
					marker2dthingy = Marker2D.new()
					get_parent().add_child(marker2dthingy)
				marker2dthingy.global_position = get_global_mouse_position()
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		if thingy14 == true:
			if thingy15 == false:
				thingy15 = true
				if not marker2dthingy2:
					marker2dthingy2 = Marker2D.new()
					get_parent().add_child(marker2dthingy2)
				marker2dthingy2.global_position = get_global_mouse_position()
				pointtowards = 1
func _physics_process(delta: float) -> void:
	var bcallback = Callable(self, "spawn")
	for node in get_tree().get_nodes_in_group("camp"):
		if not node.is_connected("spawn", bcallback):
			node.connect("spawn", bcallback)
	var acallback = Callable(self, "create")  # define the Callable
	for node in get_tree().get_nodes_in_group("thingy"):
		if not node.is_connected("create", acallback):
			node.connect("create", acallback)
	if 0 >= hp :
		print("yay")
		if thingy == true:
			thingy = false
			emit_signal("unselect", maxhp)
		queue_free()
	if thingy:
		if thingy14 == true:
			if thingy15 == true:
				if pointtowards == 1:
					var direction = marker2dthingy.global_position - global_position
					rotation = direction.angle() + deg_to_rad(90)
					var vel = direction
					if vel.length() > max_speed:
						vel = vel.normalized() * max_speed
					velocity = vel
					move_and_slide()
					if direction.length() < 100:
						vel = direction *1.5
					if direction.length() < 80:
						vel = direction *1.5
					if direction.length() < 50:
						vel = direction *2
					if direction.length() < 5:
						pointtowards += 1
						vel = direction * 4
				if pointtowards == 2:
					var direction = marker2dthingy2.global_position - global_position
					rotation = direction.angle() + deg_to_rad(90)
					var vel = direction
					if vel.length() > max_speed:
						vel = vel.normalized() * max_speed
					velocity = vel
					move_and_slide()
					if direction.length() < 100:
						vel = direction *1.5
					if direction.length() < 80:
						vel = direction *1.5
					if direction.length() < 50:
						vel = direction *2
					if direction.length() < 5:
						pointtowards -= 1
						vel = direction * 4
			else:
				var direction = marker2dthingy.global_position - global_position
				rotation = direction.angle() + deg_to_rad(90)
				var vel = direction
				if vel.length() > max_speed:
					vel = vel.normalized() * max_speed
				velocity = vel
				move_and_slide()
				if direction.length() < 5:
					velocity = Vector2.ZERO
					thingy14 = false
					thingy = false
					emit_signal("unselect")
		else:
			var direction = get_global_mouse_position() - global_position
			rotation = direction.angle() + deg_to_rad(90)
			var vel = direction
			if vel.length() > max_speed:
				vel = vel.normalized() * max_speed
			velocity = vel
			move_and_slide()
	else:
		rotation_degrees += 4.5
		if thingy13 == true:
			rotation_degrees += 9
		if $RayCast2D.is_colliding():
			var direction = $RayCast2D.get_collision_point()  - global_position
			var vel = direction
			if vel.length() > max_speed:
				vel = vel.normalized() * max_speed
			velocity = vel
			move_and_slide()
			rotation_degrees -= 4.5
func _on_timer_timeout() -> void:
	is_hit = false
	self.modulate = Color.WHITE
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		thingy12 = body
		if thingy12 and thingy12.has_method("takedamage"):
			thingy12.takedamage()

func takedamage():
	if is_hit == false:
		self.modulate = Color.FOREST_GREEN
		hp -= 1
		$Timer.start()
		is_hit = true
		if $RayCast2D.is_colliding():
			var direction = global_position - $RayCast2D.get_collision_point() 
			var vel = direction
			vel = vel.normalized() *(max_speed *30)
			velocity = vel
			move_and_slide()
	if 0 >= hp :
		print("yay")
		if thingy == true:
			thingy = false
			emit_signal("unselect", maxhp)
		queue_free()
func win():
	if thingy == true:
		thingy = false
		emit_signal("unselect", maxhp)
func create(thingy3: Variant) -> void:
	if thingy == true:
		if thingy15 == false:
				thingy = false
				emit_signal("unselect", maxhp)
				queue_free()

func _on_timer_2_timeout() -> void:
	if exp >= 3:
		maxhp = 2 * maxhp
		hp = maxhp
		exp = 0
	if berryxp >= 30:
		hp += 1
		berryxp = 0
