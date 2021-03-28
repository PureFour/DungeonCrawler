extends ColorRect

signal fade_in_finished

func fade_in() -> void:
	$AnimationPlayer.play("fade_in")

func _on_animation_finished(_anim_name: String) -> void:
	emit_signal("fade_in_finished")
