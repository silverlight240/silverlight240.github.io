extends CharacterBody2D

var direction = 1.0
const SPEED = -300.0
const JUMP_VELOCITY = -400.0
@onready var timer = $Timer
@export var health = 3
func _physics_process(delta: float) -> void:
	$Node2D.scale.x = direction
	if health <= 0:
		queue_free()
	if $Node2D/RayCast2D.is_colliding():
		direction *= -1
	velocity.x = direction * SPEED
	move_and_slide()
func _ready() -> void:
	add_to_group("animal")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		if body.form == "bee" and body.nectar > 0:
			body.items.nectar -= 1
			body.scaley.modulate = Color(1,1,0,1)
		else:
			body.health -= 1
			body.progressbar.value = 0
			body.scaley.modulate = Color(1,1,1,0.25)
		body.timer.start()
	if body.is_in_group("animal") and not body == self:
		body.health -= 1
		body.modulate = Color(200,200,200,1)
		body.timer.start()


func _on_timer_timeout() -> void:
	modulate = Color(1,1,1,1)
