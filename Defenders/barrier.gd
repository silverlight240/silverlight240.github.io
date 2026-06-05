extends StaticBody2D
var thingy12: Node2D = null
var is_hit = false
var hp = 5
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var rng := RandomNumberGenerator.new()
func _ready() -> void:
	add_to_group("player")
	rng.randomize()


func die():
	emit_signal("gainwood")
	queue_free()
func takedamage():
	if is_hit == false:
		hp -= 1
		$Timer.start()
		is_hit = true
		if hp < 1:
			die()
func _on_timer_timeout() -> void:
	is_hit = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		thingy12 = body
		if thingy12 and thingy12.has_method("takedamage"):
			thingy12.takedamage()
