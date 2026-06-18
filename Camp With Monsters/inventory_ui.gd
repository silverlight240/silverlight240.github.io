extends Control
var opened = false
@export var inventory: Inventory
func _ready() -> void:
	close()
func open():
	opened = true
	$Panel.show()
	$NinePatchRect.hide()
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		if not opened:
			open()
		elif opened:
			close()
func close():
	$Panel.hide()
	$NinePatchRect.show()
	opened = false
func _on_button_pressed(button: TextureButton):
	var item = button.get_meta("item")
	print(item.name)
	if item.name == "Axe":
		get_parent().item = "axe"
	if item.name == "Wood Sword":
		get_parent().item = "sword"


func _on_timer_timeout() -> void:
	if is_instance_valid($Panel/GridContainer.get_child(0)):
		for i in $Panel/GridContainer.get_children():
			if is_instance_valid(i.get_child(0)):
				i.get_child(0).queue_free()
	if is_instance_valid($NinePatchRect/GridContainer.get_child(0)):
		for i in $NinePatchRect/GridContainer.get_children():
			if is_instance_valid(i.get_child(0)):
				i.get_child(0).queue_free()
	var id = 0
	for i in inventory.items:
		if i != null:
			if i.amount > 0:
				var spawn = TextureRect.new()
				spawn.texture = i.texture
				spawn.position = Vector2(25,25)
				$Panel/GridContainer.get_child(id).add_child(spawn)
				spawn.add_child(Label.new())
				spawn.get_child(0).text = str(i.amount)
				id += 1
	id = 0
	for i in inventory.items:
		if i != null:
			if i.amount > 0:
				if id < 4:
					var spawn = TextureButton.new()
					spawn.texture_normal = i.texture
					spawn.position = Vector2(25,25)
					$NinePatchRect/GridContainer.get_child(id).add_child(spawn)
					spawn.name = i.name
					spawn.pressed.connect(_on_button_pressed.bind(spawn))
					spawn.set_meta("item", i)
					spawn.add_child(Label.new())
					spawn.get_child(0).text = str(i.amount)
					id += 1
