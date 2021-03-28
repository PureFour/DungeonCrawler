extends Node2D

var enemies
onready var end_game_scene_path = 'res://src/UI/EndScreen.tscn'
onready var title_screen_scene_path = 'res://src/UI/TitleScreen.tscn'
onready var player = $Player

func _ready() -> void:
	$Level1/FadeOut.show()
	$Level1/FadeOut.fade_out()

func _process(_delta: float) -> void:
	pass

func reset_player_position() -> void:
	player.position.x = 20
	player.position.y = 400
	
func _on_Player_dead_player() -> void:
	get_tree().change_scene(end_game_scene_path)

func _on_Level1_level_complete() -> void:
	print('Level 1 completed!')
	$Level1.set_visible(false)
	$Level1.queue_free()
	$Level2/FadeOut.show()
	$Level2/FadeOut.fade_out()
	$Level2.set_visible(true)
	reset_player_position()


func _on_Level2_level2_complete():
	print('Level 2 completed!')
	print('Game demo completed...')
	get_tree().change_scene(title_screen_scene_path)
