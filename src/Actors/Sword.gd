extends Area2D

signal attack_finished

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, SLASH, SUPER_SLASH}
var current_state = STATES.IDLE
var knockback_vector = Vector2.ZERO
var knockback_value = 100

export var damage: int = 15

func _ready() -> void:
	set_physics_process(false)
	
func attack(right: bool) -> void: # change this!
	if right:
		_change_state(STATES.SLASH_R)
	else:
		_change_state(STATES.SLASH_L)	

func simple_attack() -> void:
	_change_state(STATES.SLASH)

func super_attack() -> void:
	_change_state(STATES.SUPER_SLASH)
	
func _change_state(new_state) -> void:
	current_state = new_state
	
	match current_state:
		STATES.IDLE: 
			set_physics_process(false)
		STATES.SLASH:
			set_physics_process(true)
			animation_player.play("Slash")
		STATES.SUPER_SLASH:
			knockback_value = 200
			damage = 50
			set_physics_process(true)
			animation_player.play("SuperSlash")
		
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Slash" or anim_name == "SuperSlash":
		_change_state(STATES.IDLE)
		knockback_value = 100
		damage = 15
		emit_signal("attack_finished")
