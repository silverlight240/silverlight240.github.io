extends StaticBody2D
signal addSeed
var growthstage = 1
var a = 0
var b = 0
var rng := RandomNumberGenerator.new()
var picked = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
signal addBerries
func _ready() -> void:
	if growthstage == 1:
		animated_sprite.play("stage 1")
	else:
		animated_sprite.play("default")
	add_to_group("player")
	add_to_group("bush")
	rng.randomize()
	position.y += rng.randi() % 1500 - 1245
	position.x += rng.randi() % 1500 - 750
func _on_area_2d_body_entered(body: Node2D) -> void:
	if growthstage > 3:
		rng.randomize()
		if picked == false:
			if body.is_in_group("player"):
				gathered()
				if body.is_in_group("gatherer"):
					b = rng.randi() % 3 + 1
					if b == 3:
						gathered()
	else:
		if body.is_in_group("player"):
			if picked == false:
				picked = true
				stuff2()
				$Timer.start()
				if body.is_in_group("gatherer"):
					stuff2()
func gathered():
	a = rng.randi() % 6 + 1
	if a == 6:
		emit_signal("addSeed")
	else:
		emit_signal("addBerries")
		$Timer.start()
		animated_sprite.play("picked")
		picked = true
func _on_timer_timeout() -> void:
	picked = false



func _on_timer_2_timeout() -> void:
	if growthstage < 5:
		stuff2()
func stuff2():
	growthstage += 1
	if growthstage == 1:
		animated_sprite.play("stage 1")
	elif growthstage == 2:
		animated_sprite.play("stage 2")
	elif growthstage == 3:
		animated_sprite.play("stage 3")
	elif growthstage >= 4:
		animated_sprite.play("default")
		picked = false
