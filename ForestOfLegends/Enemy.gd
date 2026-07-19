extends StaticBody2D
class_name Enemy
var timer: Timer
@export_group("Stats")
@export var MaxHealth: int
@export var Health: int = 0
@export var AttackSpeed: float
@export var Damage: int
@onready var player = get_tree().get_first_node_in_group("Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Health = MaxHealth
	timer = Timer.new()
	timer.wait_time = AttackSpeed
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout():
	player.Health -= clamp((Damage - player.Block),0,9999)
	player.Block = clamp((player.Block - Damage),0,9999)
