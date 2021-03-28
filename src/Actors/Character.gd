extends KinematicBody2D

export var max_health: int = 8
var current_health: int = max_health
var hit = false
var velocity: Vector2 = Vector2.ZERO
var weapon = null

func animate() -> void:
	if current_health <= 0:
		$AnimationPlayer.play("die")
		set_physics_process(false)
	if velocity.x != 0 or velocity.y != 0:
		$AnimatedSprite.play("running")
		if velocity.x > 0:
			$AnimatedSprite.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")

func move(speed = 100, _knockback = Vector2.ZERO) -> void:
	if _knockback.length() > 0:
		move_and_slide(_knockback)
	move_and_slide(velocity.normalized() * speed)

func take_damage(_count):
	print(name + " attacked!")

func init(max_health: int) -> void:
	self.max_health = max_health
	current_health = max_health
