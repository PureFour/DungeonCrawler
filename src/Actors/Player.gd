extends "res://src/Actors/Character.gd"

signal dead_player
signal camera_zoom_out
signal camera_zoom_in

onready var weapon_position = $WeaponPosition
onready var ui: Control = $Camera2D/PlayerUI
onready var camera: Camera2D = $Camera2D

enum DIRECTION {LEFT, RIGHT}
var look_direction = DIRECTION.RIGHT
var can_use_ability = false

var zoom_speed = 20.0
var zoom_factor = 1.0
var zoom_max = 0.5
var zoom_min = 0.25

func _ready():
	init(8)
	weapon = $WeaponPosition/Sword
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")
	weapon.knockback_vector = velocity

func _physics_process(_delta: float) -> void:
	animate()
	handle_controls()
	move()
	move_weapon()
	handle_stamina()
	handle_camera_zoom(_delta)

func handle_controls() -> void:
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		$AnimatedSprite.flip_h = false
		velocity.x += 1
		look_direction = DIRECTION.RIGHT
	if Input.is_action_pressed('ui_left'):
		$AnimatedSprite.flip_h = true
		velocity.x -= 1
		look_direction = DIRECTION.LEFT
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed("attack"):
		weapon.simple_attack()
	if Input.is_action_pressed("super_attack") and can_use_ability:
		weapon.super_attack()
		can_use_ability = false
		ui.stamina_bar.value = 0

func move_weapon() -> void:
	var angle = get_local_mouse_position().angle()
	var weapon_distance = weapon_position.position.length()
	weapon_position.position.x = cos(angle) * weapon_distance
	weapon_position.position.y = sin(angle) * weapon_distance
	weapon.knockback_vector = weapon_position.position
	weapon_position.rotation = angle

func handle_stamina() -> void: 
	if ui.stamina_bar.value == 100 and not can_use_ability:
		can_use_ability = true
		
func _on_Chest_loot_picked(hp: int) -> void:
	print("chest_loot_picked: " + String(hp))
	heal(hp)
	
func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Monster_Hitbox" and not hit:
		hurt()
		if current_health <= 0:
			queue_free()
			emit_signal("dead_player")

func _on_Hitbox_area_exited(area: Area2D) -> void:
	if area.name == "Monster_Hitbox" and hit:
		hit = false
		
func heal(value: int) -> void:
	if value + current_health > max_health:
		current_health = max_health
	else:	
		current_health += value
	ui.add_health(value)
	
func hurt() -> void:
	$AnimationPlayer.play("hurt")
	current_health -= 1
	$HurtEffect.play()
	ui.reduce_health(1)
	ui.add_stamina()
	hit = true

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "hurt":
		$AnimationPlayer.stop()

func handle_camera_zoom(delta: float) -> void:
	var zoom_value = lerp(camera.zoom.x, camera.zoom.x * zoom_factor, zoom_speed * delta)
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom_factor = 1.1
		emit_signal("camera_zoom_out")
	if Input.is_action_just_released("camera_zoom_out"):
		zoom_factor = 0.9
		emit_signal("camera_zoom_in")
		
	zoom_value = clamp(zoom_value, zoom_min, zoom_max)
	camera.zoom = Vector2(zoom_value, zoom_value)
