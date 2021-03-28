extends Node2D

signal level_complete
onready var key_picked: bool = false
onready var doors = $Doors

func _on_Key_key_picked() -> void:
	key_picked = true
	doors.open()
	print('Key picked!')

func _on_Doors_body_entered(body: Node) -> void:
	if 'Player' in body.name and key_picked:
		print('Player entered doors area!')
		emit_signal("level_complete")
