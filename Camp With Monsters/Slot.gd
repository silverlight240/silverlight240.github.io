extends TextureButton
@export var slot: int = 0
@export var item: Item
@onready var playerinventory = get_parent().get_parent().get_parent()
func _physics_process(delta: float) -> void:
	if playerinventory.inventory.items[slot] != null:
		item = playerinventory.inventory.items[slot]
		if item.amount > 0:
			$TextureRect.texture = item.texture
		else:
			playerinventory.inventory.items[slot] = null


func _on_pressed() -> void:
	if item == null:
		if playerinventory.helditem != null:
			playerinventory.inventory.items[slot] = playerinventory.helditem
			playerinventory.helditem = null
	elif item != null:
		if playerinventory.helditem != null:
			playerinventory.inventory.items[slot] = playerinventory.helditem
			playerinventory.helditem = item
		elif playerinventory.helditem == null:
			playerinventory.helditem = item
			item = null
			playerinventory.inventory.items[slot] = null
			$TextureRect.texture = null
