extends Bullet
@onready var particles = $GPUParticles2D
func _exit_tree() -> void:
	get_parent().spawned = false
