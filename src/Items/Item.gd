extends Area2D

signal is_grabbed
var attribute
var body_entered = false
var can_pickup = false
var pickup_effect_played = false
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func _process(delta: float) -> void:
	handle_pickup()
	if not $PickUpEffect.is_playing() and pickup_effect_played:
		emit_signal("is_grabbed", attribute) #dodaje effekt jak wypije
		queue_free()

func handle_pickup() -> void:
	if body_entered and can_pickup and Input.is_action_just_pressed("use"):
		play_pickup_effect()
		set_visible(false)

func _on_Item_body_entered(body: Node) -> void:
	if "Player" == body.name:
		body_entered = true
		#print("OH! ITS POTION?!")

func play_pickup_effect() -> void:
	$PickUpEffect.play()
	pickup_effect_played = true


func _on_Item_body_exited(body: Node) -> void:
	body_entered = false


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	can_pickup = true
