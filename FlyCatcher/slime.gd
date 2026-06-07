extends CharacterBody2D
@onready var frog = get_tree().get_first_node_in_group("frog")
@onready var camera = $Camera2D
@export var flies = 0
@onready var spawner = $Node2D
var placedwebs =[]
var webs = 0
var speed = 550.0
var meats = 0
var tempspeed = 0
var placedmeats = []
const JUMP_VELOCITY = -400.0
func _ready() -> void:
	var stats = SaveLoad.Load("player")
	if typeof(stats) != TYPE_DICTIONARY:
		stats = {"scale": {
		"x": 1,
		"y": 1
		}, "flies": 0, "speed": 500, "zoom":{"x": 0.75,"y": 0.75,}, "spawntime": 4.00, "webs": 0, "range":{"x": 91.0,"y": 96.0}}
	flies = stats["flies"]
	meats = stats["meats"]
	speed = stats["speed"]
	if stats["placedmeats"].size() > 0:
		placedmeats = stats["placedmeats"]
		print(stats["placedmeats"])
		for meat_position in placedmeats.duplicate():
			var meat = load("res://meat.tscn")
			var scene = meat.instantiate()
			scene.global_position = Vector2(meat_position["x"],meat_position["y"])
			get_tree().current_scene.call_deferred("add_child",scene)
			print(scene)
			placedwebs.erase(meat_position)
	if stats["placedwebs"].size() > 0: 
		placedwebs = stats["placedwebs"]
		print(stats["placedwebs"])
		for web_position in placedwebs.duplicate():
			var web = load("res://cobwebtrap.tscn")
			var scene = web.instantiate()
			scene.global_position = Vector2(web_position["x"],web_position["y"])
			get_tree().current_scene.call_deferred("add_child",scene)
			print(scene)
			placedwebs.erase(web_position)
	$Area2D/CollisionShape2D.shape.size = Vector2(
	stats["range"]["x"],
	stats["range"]["y"]
	)
	webs = stats["webs"]
	scale = Vector2(
	stats["scale"]["x"],
	stats["scale"]["y"]
	)
	spawner.timer.wait_time = stats["spawntime"]
	$Camera2D.zoom = Vector2(
	stats["zoom"]["x"],
	stats["zoom"]["y"]
	)
	add_to_group("player")
	randomize()
@onready var area2d = $Area2D
func _physics_process(delta: float) -> void:
	var stats = {"meats": meats, "placedmeats": placedmeats, "placedwebs": placedwebs, "flies": flies, "speed": speed, "zoom":{"x": $Camera2D.zoom.x,"y": $Camera2D.zoom.y,}, "webs": webs, "spawntime": spawner.timer.wait_time, "scale": {
	"x": scale.x,
	"y": scale.y
	},
	"range":{
	"x": $Area2D/CollisionShape2D.shape.size.x,
	"y": $Area2D/CollisionShape2D.shape.size.y,
	}}
	SaveLoad.contents["player"] = stats
	if webs == 0:
		$Cobweb.modulate = Color(0.2,0.2,0.2,0.4)
		$Cobweb/Label.text = ""
	else:
		$Cobweb.modulate = Color(1,1,1,0.7)
		$Cobweb/Label.text = str(webs)
	if meats == 0:
		$Meat.modulate = Color(0.2,0.2,0.2,0.4)
		$Meat/Label2.text = ""
	else:
		$Meat.modulate = Color(1,1,1,0.7)
		$Meat/Label2.text = str(meats)
	$Timer2.wait_time = (speed/389.6103896103896)
	if $Timer2.wait_time >= 1:
		$Timer2.wait_time = 0.99
	$Timer.wait_time = 1 - $Timer2.wait_time
	frog = get_tree().get_first_node_in_group("frog")
	if frog:
		$Node2D2.rotation = ((frog.global_position - global_position).normalized()).angle()
	$Label.text = str(flies)
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2()
	direction.x = Input.get_axis("ui_left","ui_right")
	direction.y = Input.get_axis("ui_up","ui_down")
	if Input.is_action_just_pressed("e"):
		if webs > 0:
			webs -= 1
			var web = load("res://cobwebtrap.tscn")
			var spawnweb = web.instantiate()
			spawnweb.global_position = global_position + 0.75 * (speed * direction)
			get_parent().add_child(spawnweb)
	if Input.is_action_just_pressed("jump"):
		$AnimatedSprite2D.play("Bugnet")
		$Whoosh.pitch_scale = randf_range(0.7,0.9)
		$Whoosh.volume_db = randf_range(2.2,2.4)
		$Whoosh.play()
		$Slimesquelch.stop()
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
			$Area2D.scale.x = -1
		$Timer.start()
	if $AnimatedSprite2D.animation != "Bugnet":
		$Whoosh.stop()
		if $Slimesquelch.playing == false:
			$Slimesquelch.volume_db = randf_range(4.4,5.4)
			$Slimesquelch.pitch_scale = randf_range(0.7,1.1)
			$Slimesquelch.play()
	if direction and $AnimatedSprite2D.animation != "Bugnet":
		$AnimatedSprite2D.flip_h = false
		$Area2D.scale.x = 1
		if tempspeed < speed:
			tempspeed += (speed/100) - tempspeed/67.5
		velocity = direction * tempspeed
	else:
		velocity.x = 0
		velocity.y = 0
		tempspeed = move_toward(tempspeed,10,3 * ((speed/100) - tempspeed/67.5))
	move_and_slide()


func _on_timer_timeout() -> void:
	$Area2D.monitoring = true
	$Timer2.start()


func _on_timer_2_timeout() -> void:
	$Area2D.monitoring = false
	$AnimatedSprite2D.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	if not $Beep.playing:
		$Beep.play()
	flies += body.giveamount


func _on_timer_3_timeout() -> void:
	SaveLoad.save()


func _on_timer_4_timeout() -> void:
	$Beep.stop()
