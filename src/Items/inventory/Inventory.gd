extends Resource

class_name Inventory

signal items_changed

export(Array, Resource) var items = [
	null, null, null,
	null, null, null,
	null, null, null
]

func set_item(item_index: int, item: InventoryItem) -> InventoryItem:
	var previousItem = items[item_index]
	items[item_index] = item
	emit_signal("items_changed", [item_index])
	return previousItem
	
func swap_items(item_index: int, target_item_index: int) -> void:
	var target_item = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = target_item
	emit_signal("items_changed", [item_index, target_item_index])

func remove_item(item_index: int) -> InventoryItem:
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previousItem
