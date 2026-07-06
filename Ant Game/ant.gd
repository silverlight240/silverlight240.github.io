extends CharacterBody2D
@export var forms = ["ant"]
var damaged = false
var health = 4
var MaxHealth = 4
var zoom = false
@onready var timmer = $Timer10
@export var items = {"nectar": 0,}
var cool = false
var inwater = false
var down = 0.0
var timenotinwater = 0.0
@onready var nectar = items.nectar
var current = 0
var temphp = 4
var animation = null
@onready var timerr = $Timer9
@onready var progressbar = $ProgressBar
@export var form: String = "ant"
var a = 1
var whackwasp = false
var flyvector: Vector2
var kick = false
var jump = false
var direction := Input.get_axis("ui_left", "ui_right")
var Direction: Vector2
@onready var scaley = $Node2D2
const SPEED = 450.0
const JUMP_VELOCITY = -300.0
func _ready() -> void:
	add_to_group("player")
@onready var timer = $Timer
@onready var timer2 = $Timer2
func _on_area_2d_body_entered(body: Node2D) -> void:
	if form == "wasp":
		if body.is_in_group("animal"):
			body.health -= 3
			body.modulate = Color(200,200,200,1)
			body.timer.start()
			velocity.x = ($Node2D2.scale.x) * (SPEED * 55)
			body.velocity.x = ($Node2D2.scale.x) * (SPEED * -25)
			move_and_slide()
			move_and_slide()
			move_and_slide()
			body.move_and_slide()
			body.move_and_slide()
			body.move_and_slide()
	if form == "ant":
		if body.is_in_group("animal"):
			body.health -= 1
			body.modulate = Color(200,200,200,1)
			body.timer.start()
			velocity.x = direction * (SPEED * -5)
			body.velocity.x = direction * (SPEED * 25)
			move_and_slide()
			move_and_slide()
			move_and_slide()
			body.move_and_slide()
			body.move_and_slide()
			body.move_and_slide()
		if body is StaticBody2D:
			velocity.x = direction * (SPEED * -55)
			move_and_slide()
func _physics_process(delta: float) -> void:
	if zoom:
		if $Camera2D.zoom > Vector2(0.05,0.05):
			$Camera2D.zoom *= 0.995
	if not zoom:
		if $Camera2D.zoom < Vector2(0.5,0.5):
			$Camera2D.zoom /= 0.995
	nectar = items.nectar
	if form != "fish":
		$Node2D2/Node2D2.hide()
	if is_in_group("fish"):
		remove_from_group("fish")
	$ProgressBar.hide()
	if Input.is_action_just_pressed("y"):
		$Node2D2/AnimationPlayer.play("RESET")
		current += 1
		if current >= forms.size():
			current = 0
		form = forms[current]
	if form == "ant":
		MaxHealth = 4
		$Node2D2/AnimationPlayer.speed_scale = 2
		$Node2D2/Node2D.show()
		$Node2D2/Node2D3.hide()
		collision_mask = 1
		if direction == -1:
			$CollisionShape2D2.position.x = 71.5
			$CollisionPolygon2D.position.x = 17.0
			$CollisionPolygon2D.scale.x = -1
			$CollisionPolygon2D2.scale.x = -1
			$CollisionPolygon2D2.position.x = 0
		if direction == 1:
			$CollisionShape2D2.position.x = -71.5
			$CollisionPolygon2D.position.x = -17.0
			$CollisionPolygon2D.scale.x = 1
			$CollisionPolygon2D2.scale.x = 1
		if not is_on_floor():
			velocity += get_gravity() * delta
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if Input.is_action_just_pressed("kick"):
			$Node2D2/AnimationPlayer.play("kick")
			kick = true
			$Timer3.start()
		if Input.is_action_just_pressed("jump") and is_on_floor():
			$Node2D2/AnimationPlayer.play("jump")
			jump = true
			velocity.y = -600
			$Timer4.start()
		if not kick:
			direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			if not is_on_floor() and not jump and not kick:
				$Node2D2/AnimationPlayer.play("fall")
			velocity.x = direction * SPEED
			if Input.is_action_just_pressed("kick"):
				$Node2D2/AnimationPlayer.play("kick")
				kick = true
				$Timer3.start()
			if Input.is_action_just_pressed("jump") and is_on_floor():
				$Node2D2/AnimationPlayer.play("jump")
				jump = true
				velocity.y = -1200
				$Timer4.start()
			if is_on_floor() and not jump and not kick:
				$Node2D2/AnimationPlayer.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor() and not jump and not kick:
				$Node2D2/AnimationPlayer.play("idle")
			if not is_on_floor() and not jump and not kick:
				$Node2D2/AnimationPlayer.play("fall")
	if form == "fly":
		MaxHealth = 1
		$Node2D2/Node2D3/Flybody.texture = load("res://flybody.svg")
		$Node2D2/Node2D3/Flybody.scale.x = 1
		$Node2D2/AnimationPlayer.speed_scale = 1
		$Node2D2/AnimationPlayer.play("fly")
		collision_mask = 2
		collision_mask += 1
		Direction = Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X),Input.get_joy_axis(0, JOY_AXIS_LEFT_Y))
		velocity = Direction * Vector2(400,400)
		if Direction.x > 0.1:
			$Node2D2.scale.x = abs($Node2D2.scale.x)
		elif Direction.x < -0.1:
			$Node2D2.scale.x = -abs($Node2D2.scale.x)
		if Direction.y < -0.1:
			$Node2D2/AnimationPlayer.speed_scale = 2
		elif Direction.y > 0.1:
			$Node2D2/AnimationPlayer.speed_scale = 1
		if not is_on_floor() and not is_on_ceiling():
			velocity.y += 200
	if form == "bee":
		MaxHealth = 6
		if $ProgressBar.value >= 100:
			$ProgressBar.value = 0
			for i in 10:
				var projectile = load("res://exploding bee.tscn")
				var spawnit = projectile.instantiate()
				spawnit.global_position = $Node2D2/Marker2D.global_position + Vector2(randi_range(-400,400),randi_range(-100,400))
				spawnit.scalething = 4 * $Node2D2.scale.x
				spawnit.direction =  4 * $Node2D2.scale.x
				get_parent().add_child(spawnit)
		$ProgressBar.show()
		if Input.is_action_pressed("b"):
			$ProgressBar.value += 0.1
		$Node2D2/Node2D3/Flybody.texture = load("res://bee.svg")
		$Node2D2/Node2D3/Flybody.scale.x = -1
		$Node2D2/AnimationPlayer.speed_scale = 1
		$Node2D2/AnimationPlayer.play("fly")
		collision_mask = 1
		Direction = Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X),Input.get_joy_axis(0, JOY_AXIS_LEFT_Y))
		velocity = Direction * Vector2(1200,1200)
		if Direction.x > 0.1:
			$Node2D2.scale.x = abs($Node2D2.scale.x)
		elif Direction.x < -0.1:
			$Node2D2.scale.x = -abs($Node2D2.scale.x)
		if Direction.y < -0.1:
			$Node2D2/AnimationPlayer.speed_scale = 2
		elif Direction.y > 0.1:
			$Node2D2/AnimationPlayer.speed_scale = 1
		if not is_on_floor() and not is_on_ceiling():
			velocity.y += 200
	if form == "wasp":
		MaxHealth = 4
		$Node2D2/Node2D3/Flybody.texture = load("res://waspkitebody.svg")
		$Node2D2/Node2D3/Flybody.scale.x = 1
		$Node2D2/AnimationPlayer.speed_scale = 1
		$Node2D2/AnimationPlayer.play("fly")
		collision_mask = 1
		Direction = Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X),Input.get_joy_axis(0, JOY_AXIS_LEFT_Y))
		if not whackwasp:
			velocity = Direction * Vector2(700,700)
		if Direction.x > 0.1:
			$Node2D2.scale.x = abs($Node2D2.scale.x)
		elif Direction.x < -0.1:
			$Node2D2.scale.x = -abs($Node2D2.scale.x)
		if Direction.y < -0.1:
			$Node2D2/AnimationPlayer.speed_scale = 2
		elif Direction.y > 0.1:
			$Node2D2/AnimationPlayer.speed_scale = 1
		if not is_on_floor() and not is_on_ceiling():
			if not whackwasp:
				velocity.y += 200
		if Input.is_action_just_pressed("kick") and not whackwasp and not cool:
			$Node2D2/AnimationPlayer2.play("attack")
			$Timer7.start()
			temphp = health
			health = 1000000
			whackwasp = true
			velocity.x = 14800 * $Node2D2.scale.x
	if form == "fish":
		MaxHealth = 1
		if not inwater:
			timenotinwater += 0.1
			velocity.y += 2 * (0.1 + timenotinwater)
			down = velocity.y 
		var sign = velocity.y / abs(velocity.y) + 0.2
		velocity.y = sign * (abs(velocity.y))
		add_to_group("fish")
		collision_mask = 1
		collision_mask += 4
		$Node2D2/AnimationPlayer.speed_scale = 1
		$Node2D2/AnimationPlayer.play("swim")
		Direction = Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X),Input.get_joy_axis(0, JOY_AXIS_LEFT_Y))
		if inwater:
			velocity.y = Direction.y * 400 + down
			velocity.x = Direction.x * 400
		if Direction.x > 0.1:
			$Node2D2.scale.x = abs($Node2D2.scale.x)
		elif Direction.x < -0.1:
			$Node2D2.scale.x = -abs($Node2D2.scale.x)
		if Direction.y < -0.1:
			$Node2D2/AnimationPlayer.speed_scale = 2
		elif Direction.y > 0.1:
			$Node2D2/AnimationPlayer.speed_scale = 1
		elif abs(Direction) < Vector2(0.1, 0.1) and not is_on_floor() and not is_on_ceiling():
			if inwater:
				timenotinwater = 0
				down += 0.5
		if is_on_floor() and inwater:
			down -= 50
	if form == "slug":
		MaxHealth = 5
		add_to_group("fish")
		if is_on_wall() and not $Node2D2/Node2D4/RayCast2D.is_colliding():
			for i in 3:
				velocity.y += -600
				velocity.x += -700 * get_wall_normal().x
				move_and_slide()
		$Node2D2/AnimationPlayer.play("slugwalk")
		if (not is_on_floor()) and (not is_on_wall()):
			velocity += get_gravity() * delta
		Direction.x = Input.get_axis("ui_left", "ui_right")
		Direction.y = Input.get_axis("ui_up", "ui_down")
		if Direction:
			if is_on_floor_only():
				$CollisionPolygon2D3.scale.y = 1
				velocity.x = Direction.x * SPEED
				$Node2D2/Node2D4.rotation_degrees = 0
				$Node2D2/Node2D4.position = Vector2(0,0)
				$CollisionPolygon2D3.rotation_degrees = 0
				$CollisionPolygon2D3.position = Vector2(0,0)
			if is_on_wall(): 
				velocity.x = -get_wall_normal().x * 20
				velocity.y = Direction.y * (2*SPEED)
				$Node2D2/Node2D4.rotation_degrees = -90
				$CollisionPolygon2D3.rotation_degrees = -90
				$Node2D2/Node2D4.position = Vector2(1900, -300)
				$CollisionPolygon2D3.position.x = $Node2D2/Node2D4.position.x * $Node2D2.scale.x
				$CollisionPolygon2D3.position.y = -300
				$CollisionPolygon2D3.scale.y = (4 * $Node2D2.scale.x)
				$CollisionPolygon2D3.scale.x = 0.9
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		if Input.is_action_pressed("jump") and scaley.scale.y > 0:
			scaley.scale.y = 0.125
			$CollisionPolygon2D3.scale.y = 0.5
		if Input.is_action_pressed("jump") and scaley.scale.y < 0:
			scaley.scale.y = -0.125
			$CollisionPolygon2D3.scale.y = -0.5
	if form == "crab":
		MaxHealth = 200
		$Node2D2/AnimationPlayer.play("crabwalk")
		$Node2D2/AnimationPlayer.speed_scale = 5
		zoom = true
		collision_mask = 1
		if not is_on_floor():
			velocity += get_gravity() * delta
		if Input.is_action_just_pressed("jump") and is_on_floor():
			$Node2D2/AnimationPlayer.play("jump")
			jump = true
			velocity.y = 1.55 * -1800
			$Timer4.start()
			direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x += move_toward(velocity.x,0,SPEED)
	if health <= 0:
		queue_free()
	if form == "ant" and is_on_floor():
		velocity.y += 300
	move_and_slide()
	if health > MaxHealth:
		health = MaxHealth

func _on_timer_timeout() -> void:
	scaley.modulate = Color(1,1,1,1)
	damaged = false
	a = 1
	$Timer2.stop()


func _on_timer_2_timeout() -> void:
	if damaged:
		if a == 2:
			scaley.modulate = Color(1,1,1,1)
			a = 0
		if a == 1:
			scaley.modulate = Color(1,1,1,0.25)
		a += 1
	else:
		modulate = Color(1,1,1,1)

func _on_timer_3_timeout() -> void:
	kick = false



func _on_timer_4_timeout() -> void:
	jump = false


func _on_timer_5_timeout() -> void:
	animation = $Node2D2/AnimationPlayer.current_animation
	hide()
	$Node2D2/AnimationPlayer.play("RESET")
	$Timer6.start()

func _on_timer_6_timeout() -> void:
	$Node2D2/AnimationPlayer.play(animation)
	show()


func _on_timer_7_timeout() -> void:
	cool = true
	health = temphp
	whackwasp = false
	velocity.x = 0
	$Node2D2/AnimationPlayer2.play("RESET")
	$Timer8.start()



func _on_timer_8_timeout() -> void:
	cool = false


func _on_timer_9_timeout() -> void:
	health -= 1


func _on_timer_10_timeout() -> void:
	if "Moth's Eye" in items:
		if health < MaxHealth:
			health += round(MaxHealth/8)
			scaley.modulate = Color(1,0.75,0,1)
			timer.start()
