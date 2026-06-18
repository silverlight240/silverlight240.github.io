extends CharacterBody2D
const SPEED = 400
var health = 20
var axeing = false
var item = "axe"
var swording = false
func _ready() -> void:
	$Area2D.monitoring = false
	add_to_group("player")
func _physics_process(delta: float) -> void:
	$ProgressBar.value = health
	if health <= 0:
		queue_free()
	var direction := Input.get_vector("left", "right","up","down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	if Input.is_action_pressed("space"):
		if item == "axe":
			axeing = true
			if (not $Timer.time_left < 0.99) or $Timer.is_stopped():
				$Timer.start()
			$Area2D.monitoring = true
			if direction.x == 1:
				$AnimatedSprite2D.play("AxeSide")
				$AnimatedSprite2D.flip_h = false
			if direction.x == -1:
				$AnimatedSprite2D.play("AxeSide")
				$AnimatedSprite2D.flip_h = true
			if direction.y == -1:
				$AnimatedSprite2D.play("AxeBack")
			if direction.y == 1:
				$AnimatedSprite2D.play("AxeFront")
				$AnimatedSprite2D.flip_h = true
		if item == "sword":
			swording = true
			if (not $Timer.time_left < 0.99) or $Timer.is_stopped():
				$Timer.start()
			$Area2D.monitoring = true
			if direction.x == 1:
				$AnimatedSprite2D.play("Swordside")
				$AnimatedSprite2D.flip_h = false
			if direction.x == -1:
				$AnimatedSprite2D.play("Swordside")
				$AnimatedSprite2D.flip_h = true
			if direction.y == -1:
				$AnimatedSprite2D.play("Swordback")
			if direction.y == 1:
				$AnimatedSprite2D.play("swordfront")
				$AnimatedSprite2D.flip_h = true
	else:
		if not (axeing or swording):
			if direction.x == 1:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("side of player")
			if direction.x == -1:
				$AnimatedSprite2D.play("side of player")
				$AnimatedSprite2D.flip_h = true
			if direction.y == -1:
				$AnimatedSprite2D.play("Back of Player")
			if direction.y == 1:
				$AnimatedSprite2D.play("Front of player")
				$AnimatedSprite2D.flip_h = true
			move_and_slide()


func _on_timer_timeout() -> void:
	axeing = false
	swording = false
	if not Input.is_action_pressed("space"):
		$AnimatedSprite2D.play("Front of player")
	$Area2D.monitoring = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self:
		if item == "axe":
			body.hp -= 1
			if body.is_in_group("tree"):
				if body.hp < 1:
					$Control.inventory.items[0].amount += 1
					body.queue_free()
			if body.is_in_group("slime"):
				if body.hp < 1:
					$Control.inventory.items[1].amount += 1
					body.queue_free()
		if item == "sword":
			if body.is_in_group("slime"):
				body.hp -= 2
				if body.hp < 1:
					$Control.inventory.items[1].amount += 1
					body.queue_free()
