extends Area2D

signal loot_picked

var sound_played = false
var showed_loot = false

func _on_Chest_body_entered(body):
	if not visible:
		return
	if "Player" in body.name:
		$AnimatedSprite.play("opening")
		if not sound_played:
			$OpenSound.play()
			sound_played = true
			

func _on_AnimatedSprite_animation_finished() -> void:
	$AnimatedSprite.set_visible(false)	
	show_loot()

func show_loot() -> void: #dodac ogolny loot i rozne rodzaje!
	if not showed_loot:
		$RedPotion.set_visible(true)
		$RedPotion/AnimationPlayer.play("jump_from_chest")
		showed_loot = true

func _on_RedPotion_is_grabbed(hp: int) -> void: #dodac ogolny loot i rozne rodzaje!
	emit_signal("loot_picked", hp)
	queue_free()
