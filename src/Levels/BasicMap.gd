extends Node2D

export var path_to_next_level : String = ""
var can_open: bool = false
var level_completed: bool = false

func _process(_delta: float) -> void:
	handle_open_doors()

func handle_open_doors() -> void:
	if Input.is_action_pressed("use") and can_open and level_completed:
		get_tree().change_scene(path_to_next_level)

func _on_Doors_body_entered(body: Node) -> void:
	if "Player" in body.name:
		can_open = true	

func _on_Doors_body_exited(body: Node) -> void:
	if "Player" in body.name:
		can_open = false

func _on_MainGame_level_complete() -> void:
	$Doors/AnimatedSprite.play("open")
	level_completed = true
