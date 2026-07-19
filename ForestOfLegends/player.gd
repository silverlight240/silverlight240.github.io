extends PathFollow2D
var InCombat = false
@export var MaxHealth: int
@export var Health: int = 0
@export var speed = 1
var Block = 0
var enemy: StaticBody2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Health = MaxHealth
	add_to_group("Player")
	$Control.hide()
var Oncooldown = false
@onready var timer2 = $Timer2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if InCombat:
		if Health <= 0:
			get_tree().reload_current_scene()
			$Control.show()
		$Control/AnimatedSprite2D/ProgressBar.max_value = MaxHealth
		$Control/AnimatedSprite2D/ProgressBar.value = Health
		$Control/AnimatedSprite2D2/ProgressBar.max_value = enemy.MaxHealth
		$Control/AnimatedSprite2D2/ProgressBar.value = enemy.Health
		$Control/AnimatedSprite2D2/ProgressBar2.max_value = enemy.timer.wait_time
		$Control/AnimatedSprite2D2/ProgressBar2.value = enemy.timer.time_left
		$Control/AnimatedSprite2D/ProgressBar2.max_value = $Timer.wait_time
		$Control/AnimatedSprite2D/ProgressBar2.value = $Timer.time_left
	if not InCombat:
		$Control.hide()
		$Control/AnimatedSprite2D2.sprite_frames = null
		progress += speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	InCombat = true
	$Control.show()
	enemy = body
	body.timer.start()
	$Control/AnimatedSprite2D2.sprite_frames = body.get_node("AnimatedSprite2D").sprite_frames
	$Control/AnimatedSprite2D2.play()


func _on_timer_timeout() -> void:
	Oncooldown = false


func _on_timer_2_timeout() -> void:
	Block = 0
