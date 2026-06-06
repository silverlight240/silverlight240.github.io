extends CharacterBody2D
@onready var frog = get_tree().get_first_node_in_group("frog")
@onready var camera = $Camera2D
@export var flies = 0
@onready var spawner = $Node2D
var webs = 0
var speed = 300.0
const JUMP_VELOCITY = -400.0
func _ready() -> void:
	var stats = SaveLoad.Load("player")
	flies = stats["flies"]
	speed = stats["speed"]
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
	var stats = {"speed": speed, "zoom":{"x": $Camera2D.zoom.x,"y": $Camera2D.zoom.y,}, "webs": webs, "spawntime": spawner.timer.wait_time, "scale": {
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
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
			$Area2D.scale.x = -1
		$Timer.start()
	if direction and $AnimatedSprite2D.animation != "Bugnet":
		$AnimatedSprite2D.flip_h = false
		$Area2D.scale.x = 1
		velocity = direction * speed
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()


func _on_timer_timeout() -> void:
	$Area2D.monitoring = true
	$Timer2.start()


func _on_timer_2_timeout() -> void:
	$Area2D.monitoring = false
	$AnimatedSprite2D.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	flies += body.giveamount
