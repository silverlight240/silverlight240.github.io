extends Tower

var startingwave = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	startingwave = $"../Path2D".wave


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	$Panel/Button2.text = "SELL For: " + str(int(round(value)))
	$AnimatedSprite2D.frame = $"../Path2D".wave - startingwave
	value = 20
	for i in $"../Path2D".wave - startingwave:
		value *= 1.06
		value += 0.25 * (i + 1)

func _on_button_pressed() -> void:
	$Panel.hide()


func _on_button_2_pressed() -> void:
	playercontroller.cash += value
	queue_free()
