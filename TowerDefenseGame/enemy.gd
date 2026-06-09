extends CharacterBody2D
class_name Enemy
@onready var playercontroller = get_tree().get_first_node_in_group("playercontroller")
@export_group("Stats")
@export var speed = 150.0
@export var health = 3.0
@export_group("Drops")
@export var crystals = 1.0
func _ready() -> void:
	add_to_group("enemy")
	playercontroller = get_tree().get_first_node_in_group("playercontroller")
	$ProgressBar.max_value = health
func _physics_process(delta: float) -> void:
	get_parent().progress += speed * delta
	$ProgressBar.value = health
	$ProgressBar.rotation = 0
	playercontroller = get_tree().get_first_node_in_group("playercontroller")
	if health <= 0:
		_die()
func _die():
	get_parent().queue_free()
	playercontroller.cash += crystals
