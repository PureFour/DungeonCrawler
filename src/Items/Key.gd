extends Node2D

signal key_picked

func _on_Area2D_body_entered(body: Node) -> void:
	if "Player" in body.name:
		emit_signal("key_picked")
		queue_free()
