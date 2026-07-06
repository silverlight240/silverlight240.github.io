extends Node2D
var saidno = false
var line = 1
var agreed = false
var scouthive = false
var bodi: Node2D = null
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.hide()
@export var wall: StaticBody2D
@export var wall2: StaticBody2D

func _physics_process(delta: float) -> void:
	if scouthive:
		line = 9
		$Timer.start()
		$Label.text = "Good."
		scouthive = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not ("bee" in body.forms):
		$Label.show()
		bodi = body
		$Timer.start()
func _on_timer_timeout() -> void:
	if not saidno:
		if line != 9 and line != 8:
			line += 1
		$Label.show()
		if line == 1:
			$Label.text = "Bees."
		if line == 2:
			$Label.text = "Those BEES."
		elif line == 3:
			$Label.text = "THOSE BEEEEEEEEEEEEEEEEES!"
		elif line == 4:
			$Label.text = "Their Vile Presence is second only to THE HORNET"
		elif line == 5:
			$Label.text = "It's no big wonder we attacked them after they went into our territory"
		elif line == 6:
			$Label.text = "AND STOLE OUR FLOWERS"
		elif line == 7:
			$Label.text = "Find The Hive of Those Bees And scout it out"
			$Button.show()
			$Button2.show()
			$Button3.show()
		elif line == 9 and $Label.visible:
			$Label.text = "It IS WAR!!!!!!!!!!!!!!!!!!!!!!!!!"
			bodi.forms.append("wasp")
			bodi.forms.erase("fly")
			bodi.form = "wasp"
			bodi.health = 4
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.stop()
		$Label.hide()


func _on_button_3_pressed() -> void:
	line = 1
	$Button.hide()
	$Button2.hide()
	$Button3.hide()
func _on_button_2_pressed() -> void:
	line = 0 
	saidno = true
	$Button.hide()
	$Button2.hide()
	$Button3.hide()

func _on_button_pressed() -> void:
	agreed = true
	wall.position.y += 1000
	wall2.position.y += 1000
	$Button.hide()
	$Button2.hide()
	$Button3.hide()
