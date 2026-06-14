extends Area2D
class_name Tower
var Bodey 
@onready var playercontroller = get_tree().get_first_node_in_group("playercontroller")
@export_group("Stats")
@export var ShootTimes = 1
@export var spacing = 80
@export var CareAboutEnemies = true
@export var projectile = preload("res://bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var spawnrange = Sprite2D.new()
	spawnrange.texture = GradientTexture2D.new()
	var gradient = Gradient.new()
	gradient.set_color(0,Color(0,0,0,0))
	gradient.set_color(1,Color(0,0,0,0))
	gradient.remove_point(1)
	gradient.add_point(0,Color(0,0,0,1))
	gradient.add_point(0.5,Color(0,0,0,0))
	spawnrange.texture.gradient = gradient
	spawnrange.texture.fill = GradientTexture2D.FILL_RADIAL
	spawnrange.texture.fill_from = Vector2(0.5,0.5)
	spawnrange.texture.fill_to = Vector2(0.5,0.0)
	add_child(spawnrange)
	spawnrange.name = "PointLight2D"
	print(spawnrange)
	spawnrange.hide()
	add_to_group("tower")
	var button = Button.new()
	button.flat = true
	button.size = Vector2(45,45)
	button.position = Vector2(-20,-20)
	button.set_anchors_preset(Control.PRESET_CENTER)
	button.pressed.connect(_on_pressed)
	add_child(button)
	print(button)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PointLight2D.scale.x = $CollisionShape2D.shape.radius/14
	$PointLight2D.scale.y = $CollisionShape2D.shape.radius/14

func _on_body_entered(body: Node2D) -> void:
	Bodey = body
	if get_overlapping_bodies().size() < 2:
		$Timer.start()


func _on_timer_timeout() -> void:
	if Bodey in get_overlapping_bodies() or not CareAboutEnemies:
		spawn(get_parent())
func spawn(x):
	for i in ShootTimes:
		var spawnbullet = projectile.instantiate()
		if x == get_parent():
				if CareAboutEnemies:
					spawnbullet.global_position = global_position - spacing * (i *  (Bodey.global_position - global_position ).normalized())
				else:
					spawnbullet.global_position = global_position
		if CareAboutEnemies:
			spawnbullet.target = Bodey.get_parent()
		x.add_child(spawnbullet)
func _on_pressed():
	$PointLight2D.show()
	$Panel.show()
