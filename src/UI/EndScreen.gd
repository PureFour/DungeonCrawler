extends Control

var scene_to_load

func _ready() -> void:
	$FadeOut.show()
	$FadeOut.fade_out()
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		if button.name != "ExitButton":
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load) -> void:
	self.scene_to_load = scene_to_load 
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_in_finished() -> void:
	get_tree().change_scene(scene_to_load)
