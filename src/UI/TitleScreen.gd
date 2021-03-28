extends Control

var scene_to_load: String

func _ready() -> void:
	$FadeOut.show()
	$FadeOut.fade_out()
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		if button.name == "ExitButton":
			continue
		else:	
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(_scene_to_load: String) -> void:
	scene_to_load = _scene_to_load 
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_in_finished() -> void:
	get_tree().change_scene(scene_to_load)

func _on_SliderMusic_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_SliderEffects_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), value)
