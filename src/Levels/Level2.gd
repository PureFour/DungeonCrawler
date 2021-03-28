extends Node2D

signal level2_complete
onready var key_picked: bool = false

func _on_Doors_body_entered(body: Node) -> void:
	if 'Player' in body.name and key_picked:
		print('Player entered doors area!')
		emit_signal("level2_complete")
