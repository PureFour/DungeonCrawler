extends "res://src/Items/Item.gd"

func _ready() -> void:
	attribute = rng.randi_range(1, 3)
