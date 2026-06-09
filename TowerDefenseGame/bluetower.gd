extends Tower
var spawned = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_instance_valid(get_child(3)) and not spawned:
		spawn(self)
		spawned = true


func _on_button_pressed() -> void:
	$Panel
