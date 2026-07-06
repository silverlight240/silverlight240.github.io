extends Node2D
@export var positionthing: Marker2D
@export var queen: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$Area2D/CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if queen.agreed == true:
		$Area2D/CollisionShape2D.disabled = false
		show()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Babybee/GPUParticles2D.hide()
		$Babybee/GPUParticles2D2.hide()
		$Babybee/GPUParticles2D3.hide()
		queen.babyfound = true
		global_position = positionthing.global_position
