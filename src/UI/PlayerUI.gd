extends Control

var stamina_full = false
onready var hp_bar = [$HPBar/HP1, $HPBar/HP2, $HPBar/HP3, $HPBar/HP4]
onready var stamina_bar = $StaminaBar
onready var inventory = $Inventory

var zoom_speed = 8.0
var hp_stamina_zoom_vector = Vector2.ZERO
var inventory_zoom_vector = Vector2(35.0, 0.0)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		inventory.visible = !inventory.visible
	if stamina_bar.value == 100 and not stamina_full:
		stamina_full = true
		emit_signal("stamina_full")
	handle_camera_zoom(delta)

func reduce_health(value: int) -> void:
	if _is_empty():
		return
	for i in range(hp_bar.size() - 1, 0, -1):
		if hp_bar[i].value >= 50:
			hp_bar[i].value -= 50
			value -= 1
		if value == 0:
			return
	
func add_health(value: int) -> void:
	if _is_full():
		return
	for i in range(hp_bar.size()):
		for j in range(2):
			if hp_bar[i].value <= 50 and value > 0:
				hp_bar[i].value += 50
				value -= 1
		if value == 0:
			return

func add_stamina() -> void:
	if stamina_bar.value >= 75:
		stamina_bar.value = 100
	else:
		stamina_bar.value += 25
		
func _is_empty() -> bool:
	for hp in hp_bar:
		if hp.value > 0:
			return false
	return true

func _is_full() -> bool:
	for hp in hp_bar:
		if hp.value < 100:
			return false
	return true

func _on_Player_camera_zoom_out() -> void:
	hp_stamina_zoom_vector = Vector2(150.0, -100.0)
	inventory_zoom_vector = Vector2(-115.0, -100.0)

func _on_Player_camera_zoom_in() -> void:
	hp_stamina_zoom_vector = Vector2.ZERO
	inventory_zoom_vector = Vector2(35.0, 0.0)

func handle_camera_zoom(delta: float) -> void:
	var hp_stamina_pos: Vector2 = lerp($HPBar.rect_position, hp_stamina_zoom_vector, zoom_speed * delta) 
	var inventory_pos: Vector2 = lerp(inventory.rect_position, inventory_zoom_vector, zoom_speed * delta) 
	$HPBar.rect_position = hp_stamina_pos
	stamina_bar.rect_position = hp_stamina_pos + Vector2(0.0, 15.0)
	inventory.rect_position = inventory_pos
