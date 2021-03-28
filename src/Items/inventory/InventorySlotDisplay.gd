extends CenterContainer

onready var itemTexture = $ItemTexture

var inventory = preload("res://src/Items/inventory/Inventory.tres")

var drag_preview = null

func _process(delta: float) -> void:
	if drag_preview:
		drag_preview.position = get_global_mouse_position()

func display_item(item):
	if item is InventoryItem:
		itemTexture.texture = item.texture
	else:
		itemTexture.texture = null

func get_drag_data(position: Vector2):
	var item_index = get_index()
	var item = inventory.remove_item(item_index)
	if item is InventoryItem:
		var data = {}
		data.item = item
		data.item_index = item_index
		return data
	
func can_drop_data(_position: Vector2, data) -> bool:
	return data is Dictionary and data.has("item")

func drop_data(_position: Vector2, data) -> void:
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	inventory.swap_items(my_item_index, data.item_index)
	inventory.set_item(my_item_index, data.item)
