extends Area2D

signal is_grabbed

func _on_Potion_body_shape_entered(_body_id: int, body: Node, _body_shape: int, _area_shape: int) -> void:
	if "Player" == body.name and Input.is_action_pressed("use"):
		print("OH! ITS POTION?!")
		emit_signal("is_grabbed", 10)
		queue_free()
