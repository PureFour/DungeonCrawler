extends Area2D

func open() -> void:
	$AudioStreamPlayer2D.play()
	$AnimatedSprite.play('open')
