extends StaticBody2D

signal gainwood
var is_hit = false
var hp = 5
var log = 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var rng := RandomNumberGenerator.new()
func _ready() -> void:
	add_to_group("log")
	rng.randomize()
	log = rng.randi() % 2 + 1
	position.y += rng.randi() % 3000 - 2500
	position.x += rng.randi() % 3000 - 1500
	rotation_degrees = rng.randi_range(0, 360)

func _process(delta: float) -> void:
	if log == 1:
		animated_sprite.play("default")
	if log == 2:
		animated_sprite.play("log2")
func die():
	emit_signal("gainwood")
	queue_free()
func takedamage():
	if is_hit == false:
		hp -= 1
		$Timer.start()
		if hp < 1:
			die()
func _on_timer_timeout() -> void:
	is_hit = false
