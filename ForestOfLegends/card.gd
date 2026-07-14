@icon("res://Card.png")
extends TextureButton
class_name Card
@onready var player = get_tree().get_first_node_in_group("Player")
@export var texture: CompressedTexture2D
@export_group("Stats")
@export var DoesDamage: bool
@export var Cooldown: float
@export var Damage: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	texture_normal = load("res://Card.png")
	add_child(TextureRect.new())
	get_child(0).texture = texture
	get_child(0).scale = Vector2(2,2)
	get_child(0).position = Vector2(100,100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("Player")
	if player.Oncooldown:
		modulate = Color(0.5,0.5,0.5,0.5)
	else:
		modulate = Color.WHITE



func _on_pressed() -> void:
	if DoesDamage and not player.Oncooldown:
		player.Oncooldown = true
		player.get_node("Timer").wait_time = Cooldown
		player.get_node("Timer").start()
		player.enemy.Health -= Damage
		if player.enemy.Health <= 0:
			player.enemy.queue_free()
			player.InCombat = false
