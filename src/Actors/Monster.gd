extends "res://src/Actors/Character.gd"

var target
var health_bar = null
var knockback = Vector2.ZERO

func _ready() -> void:
	init(100)
	health_bar = $HealthIndicator/HealthBar

func _physics_process(delta: float) -> void:
	animate()
	if target:
		followPlayer(target) 
	knockback = knockback.move_toward(Vector2.ZERO, 1000 * delta)
	move(125, knockback)

func followPlayer(body: Node) -> void:
	velocity = position.direction_to(body.position)

func _on_view_range_body_entered(body: Node) -> void:
	if "Player" in body.name:  #follow player
		#print("Player spotted!")
		target = body
	if body.is_in_group("weapon"):
		print("Hit by weapon!")	

func _on_view_range_body_exited(body: Node) -> void:
	if "Player" in body.name:
		#print("Player lost!")
		velocity = Vector2.ZERO
		target = null

func collision(body: Node) -> void:
	if (body.name != "Player"):
		return
	print("Colliding with" + body.name)	
	
func _on_Hitbox_area_entered(area: Area2D) -> void:
	#print("hitbox detect " + area.name)
	if area.name == "Sword" and not hit:
		current_health -= area.damage
		health_bar.value = current_health
		$AnimationPlayer.play("hurt")
		knockback = area.knockback_vector * area.knockback_value
		hit = true
#		if current_health <= 0:
#			queue_free()

func _on_Hitbox_area_exited(area: Area2D) -> void:
	if area.name == "Sword" and hit:
		hit = false


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
#	if anim_name == "hurt":
#		$AnimationPlayer.stop()
	if anim_name == "die":
		print("die finished!")
		queue_free()
