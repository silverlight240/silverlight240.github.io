@icon("res://InstinctCard.png")
extends TextureRect
class_name InstinctCard
@onready var player = get_tree().get_first_node_in_group("Player")
@export var texturee: CompressedTexture2D
@export_group("Stats")
@export var Cooldown: float
@export var Damage: int
@export var Sheild: int
@export var SheildDuration: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	texture = load("res://InstinctCard.png")
	add_child(TextureRect.new())
	get_child(0).texture = texturee
	get_child(0).scale = Vector2(0.75,0.75)
	get_child(0).position = Vector2(25,25)
	add_child(Timer.new())
	get_child(1).wait_time = Cooldown
	get_child(1).start()
	get_child(1).timeout.connect(on_timer_timeout)
	add_child(ProgressBar.new())
	get_child(2).max_value = Cooldown
	get_child(2).show_percentage = false
	get_child(2).size = Vector2(137, 27)
	get_child(2).modulate = Color(0.2,0.2,200,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("Player")
	get_child(2).value = get_child(1).time_left
func on_timer_timeout():
	if player.InCombat:
		get_child(1).start()
		player.enemy.Health -= Damage
		if player.enemy.Health <= 0:
			player.enemy.queue_free()
			player.InCombat = false
		player.Block += Sheild
		player.timer2.start()
