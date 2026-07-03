extends Node2D
var line = 0

@export var line1: String 
@export var line2: String 
@export var line3: String 
@export var line4: String 
@export var line5: String 
func _ready() -> void:
	$Node2D/Label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Node2D/Label.show()
		$Node2D/Label.text = line1
		$Timer.start()


func _on_timer_timeout() -> void:
	line += 1
	if line == 2:
		$Node2D/Label.text = line2
	elif line == 3:
		$Node2D/Label.text = line3
	elif line == 4:
		$Node2D/Label.text = line4
	elif line == 5:
		$Node2D/Label.text = line5
		line = 0

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.stop()
		$Node2D/Label.hide()
