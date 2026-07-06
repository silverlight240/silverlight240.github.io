extends CharacterBody2D
var Body: Node2D = null
var health = 150
var slide = false
var phase = 1
var dash = 1
@export var markertarget: Marker2D
@onready var thingything = preload("res://projectile.tscn")
@export var bode = CharacterBody2D
var attack = "none"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("animal")
	add_to_group("moth")
	randomize()
@onready var timer = $Timer
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 75:
		phase = 2
		$ProgressBar.modulate = Color(2,0.0,0.0,1)
	$ProgressBar.value = health / 1.5
	if attack == "none":
		if is_instance_valid(bode) and ("bee" in bode.forms or "wasp" in bode.forms):
			$Area2D.monitoring = true
			show()
			if $RayCast2D.is_colliding():
				Body = $RayCast2D.get_collider()
				velocity = (($RayCast2D.get_collider().global_position - global_position).normalized()) * 750
			elif $RayCast2D2.is_colliding():
				Body = $RayCast2D2.get_collider()
				velocity = (($RayCast2D2.get_collider().global_position - global_position).normalized()) * 750
			elif $RayCast2D3.is_colliding():
				Body = $RayCast2D3.get_collider()
				velocity = (($RayCast2D3.get_collider().global_position - global_position).normalized()) * 750
			elif $RayCast2D4.is_colliding():
				Body = $RayCast2D4.get_collider()
				velocity = (($RayCast2D4.get_collider().global_position - global_position).normalized()) * 750
			else:
				velocity += ((markertarget.global_position - global_position).normalized()) * 1
			move_and_slide()
			if health <= 0:
				bode.health = 4
				bode.items["Moth's Eye"] = 1
				bode.timmer.start()
				queue_free()
		else:
			$Area2D.monitoring = false
			hide()
	elif attack == "dash" and slide:
		move_and_slide()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if attack == "dash" and phase == 1 and not body is CharacterBody2D:
		attack = "none"
	if attack == "dash" and phase == 2 and dash == 1:
		dash = 2
		$Timer5.start()
		$Timer4.stop()
		$Mothwing.modulate = Color(1,0,0,1)
		$Mothwing2.modulate = Color(1,0,0,1)
	if attack == "dash" and phase == 2 and dash == 2 and not body is CharacterBody2D:
		attack = "none"
	if body.is_in_group("player") and not body.damaged:
		body.damaged = true
		if body.form == "bee" and body.nectar > 0:
			body.items.nectar -= 1
			body.scaley.modulate = Color(1,1,0,1)
			body.timer.start()
		else:
			body.health -= 1
			body.scaley.modulate = Color(1,1,1,0.25)
			body.timer.start()
			body.timer2.start()


func _on_timer_timeout() -> void:
	modulate = Color(1,1,1,1)


func _on_timer_3_timeout() -> void:
	if Body != null:
		if attack == "none":
			var a = randi_range(1,2)
			if a == 2:
				attack = "dash"
				$Timer5.start()
				$Mothwing.modulate = Color(1,0,0,1)
				$Mothwing2.modulate = Color(1,0,0,1)
			if a == 1:
				attack = "slice"
				$Timer5.start()
				$Mothwing.modulate = Color(0,1,0,1)
				$Mothwing2.modulate = Color(0,1,0,1)
func _on_timer_4_timeout() -> void:
	slide = false
	print(phase)
	print(attack)
	print(dash)
	if dash == 2 or phase == 1 or attack != "dash":
		dash = 1
		attack = "none"
	velocity = Vector2.ZERO
	if phase == 2 and dash == 1 and attack == "dash":
		dash = 2
		$Timer5.start()
		$Mothwing.modulate = Color(1,0,0,1)
		$Mothwing2.modulate = Color(1,0,0,1)

func _on_timer_5_timeout() -> void:
	$Mothwing.modulate = Color(1,1,1,1)
	$Mothwing2.modulate = Color(1,1,1,1)
	if attack == "dash":
		velocity = 3200 * (Body.global_position - global_position).normalized()
		$Timer6.start()
	if attack == "slice":
			$Timer4.start()
			var thigythig = thingything.instantiate()
			thigythig.target = Body.global_position
			thigythig.global_position = global_position - (400 * (global_position - Body.global_position).normalized())
			get_parent().add_child(thigythig)
			thigythig = thingything.instantiate()
			thigythig.target = Body.global_position - Vector2(0,800)
			thigythig.global_position = global_position - (400 * (global_position - Body.global_position).normalized())
			get_parent().add_child(thigythig)
			thigythig = thingything.instantiate()
			thigythig.target = Body.global_position - Vector2(0,400)
			thigythig.global_position = global_position - (400 * (global_position - Body.global_position).normalized())
			get_parent().add_child(thigythig)
			thigythig = thingything.instantiate()
			thigythig.target = Body.global_position - Vector2(0,-400)
			thigythig.global_position = global_position - (400 * (global_position - Body.global_position).normalized())
			get_parent().add_child(thigythig)
			thigythig = thingything.instantiate()
			thigythig.target = Body.global_position - Vector2(0,-800)
			thigythig.global_position = global_position - (400 * (global_position - Body.global_position).normalized())
			get_parent().add_child(thigythig)
			if phase == 2:
				thigythig = thingything.instantiate()
				thigythig.target = Body.global_position
				thigythig.global_position = global_position
				get_parent().add_child(thigythig)
				thigythig = thingything.instantiate()
				thigythig.target = Body.global_position - Vector2(0,600)
				thigythig.global_position = global_position
				get_parent().add_child(thigythig)
				thigythig = thingything.instantiate()
				thigythig.target = Body.global_position - Vector2(0,300)
				thigythig.global_position = global_position
				get_parent().add_child(thigythig)
				thigythig = thingything.instantiate()
				thigythig.target = Body.global_position - Vector2(0,-300)
				thigythig.global_position = global_position 
				get_parent().add_child(thigythig)
				thigythig = thingything.instantiate()
				thigythig.target = Body.global_position - Vector2(0,-600)
				thigythig.global_position = global_position
				get_parent().add_child(thigythig)


func _on_timer_6_timeout() -> void:
	$Timer4.start()
	slide = true
