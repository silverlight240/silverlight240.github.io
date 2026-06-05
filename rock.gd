extends StaticBody2D
@onready var animated_sprite: AnimatedSprite2D = $Sprite2D
var rock = 0
var rng := RandomNumberGenerator.new()
func _ready() -> void:
	rng.randomize()
	rock = rng.randi() % 3 + 1
	position.y += rng.randi() % 3000 - 2500
	position.x += rng.randi() % 3000 - 1500


func _process(delta: float) -> void:
	if rock == 1:
		animated_sprite.play("Rock1")
		$Rock2.disabled = true
		$Rock3.disabled = true
	if rock == 2:
		animated_sprite.play("Rock2")
		$Rock1.disabled = true
		$Rock3.disabled = true
	if rock == 3:
		animated_sprite.play("Rock3")
		$Rock2.disabled = true
		$Rock1.disabled = true
