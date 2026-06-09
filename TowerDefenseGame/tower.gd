extends Area2D
class_name Tower
var Bodey 
@export var CareAboutEnemies = true
@export var projectile = preload("res://bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("tower")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Bodey = body
	if get_overlapping_bodies().size() < 2:
		$Timer.start()


func _on_timer_timeout() -> void:
	if Bodey in get_overlapping_bodies() or not CareAboutEnemies:
		spawn(get_parent())
func spawn(x):
		var spawnbullet = projectile.instantiate()
		if x == get_parent():
			spawnbullet.global_position = global_position
		if CareAboutEnemies:
			spawnbullet.target = Bodey.get_parent()
		x.add_child(spawnbullet)
