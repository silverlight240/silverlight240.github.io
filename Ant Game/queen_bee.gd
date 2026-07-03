extends Node2D
var line = 1
var findnectar = false
var bodey: Node2D = null
var babyfound = false
func _ready() -> void:
	$Node2D/Label.hide()
	$Button.hide()
	$Button2.hide()
	$Node2D3.hide()
var found = false
var agreed = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not ("wasp" in body.forms):
		$Node2D/Label.show()
		$Timer.start()
		bodey = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.stop()
		$Node2D/Label.hide()
		$Button.hide()
		$Button2.hide()
func _on_timer_timeout() -> void:
	if line != 8 and line != 10 and line != 11:
		line += 1
	if babyfound:
		line = 11
	if line == 2:
		$Node2D/Label.text = "Honey, I see you do not know who we are."
	elif line == 3:
		$Node2D/Label.text = "We are the bees, we are usually peaceful but we have two enemies."
	elif line == 4:
		$Node2D/Label.text = "THE HORNET and the wasps"
	elif line == 5:
		$Node2D/Label.text = "Won'tcha BEElieve it, The wasps Have Declared war on us"
	elif line == 6:
		$Node2D/Label.text = "To Prepare we need food, could you find us nectar"
		findnectar = true
	elif line == 9:
		$Node2D/Label.text = "Thanks for the nectar, You see we have a lost larva"
		$Node2D3.show()
	elif line == 10:
		$Node2D/Label.text = "Will you help us find her"
		$Button.show()
		$Button2.show()
		$Button2.text = "No"
	elif line == 11 and $Node2D/Label.visible:
		$Node2D/Label.text = "You Found our sweet li'l BaBEE Thanks So Much"
		babyfound = false
		bodey.forms.append("bee")
		bodey.forms.erase("fly")
		bodey.form = "bee"
		bodey.health = 6
	if bodey.nectar < 6:
		line = 6
	if findnectar and bodey.nectar >= 6 and line <= 6:
		$Node2D/Label.text = "I See you Have nectar, You're So Productive! I did not have to ask"
	if findnectar and bodey.nectar >= 6 and line == 7:
		$Node2D/Label.text = "You Have Collected Nectar"
	if line == 8 and findnectar:
		$Node2D/Label.text = "Will You Give me the nectar"
		$Button.show()
		$Button2.show()
	if line == 8 and not findnectar:
		line = 1


func _on_button_2_pressed() -> void:
	if line == 8 and findnectar:
		findnectar = false
		$Button.hide()
		$Button2.hide()




func _on_button_pressed() -> void:
	if line == 8 and findnectar:
		findnectar = false
		found = true
		$Node2D/Label.text = "Thanks for the nectar, You see we have a lost larva"
		line = 9
		$Timer.start()
		$Node2D3.show()
	elif line == 10:
		agreed = true
	$Button.hide()
	$Button2.hide()
