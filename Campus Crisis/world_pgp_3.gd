extends Node2D
var gameOverAudioPlayed: bool = false
signal gameOver
#new ally is npc2

# Called when the node enters the scene tree for the first time.
func _ready():
	$"audio/background gameplay".play()
	$"audio/lion start roar".play()
	$"audio/crowd screaming".play()
	Global.current_location = "pgp"
	$hud/TagButton.hide() 
	$hud/Tick.hide()
	$hud/Cross.hide()
	$hud/PauseMenu.hide()
	$hud/ScoreTimer.start()
	$hud/gameOverPanel.hide()
	$player/Camera2D.limit_bottom = 2560
	$player/Camera2D.limit_right = 26480
	$hud/torchButton.disabled = true
	$hud/sprayButton.disabled = true
	$hud/hornButton.disabled = true
	$hud/torchButton.hide()
	$hud/sprayButton.hide()
	$hud/hornButton.hide()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lion_dist: int = $lion.position.x - $player.position.x

func _on_ally_hit():
	$hud/TagButton.show()
	
func _on_ally_exit():
	$hud/TagButton.hide()

func _on_hud_message_disappear():
	$hud/Cross.hide()

func _on_hud_pressed_tag():
	$hud._on_tagged_button_pressed()

func _on_lion_player_killed():
	emit_signal("gameOver")
	if not gameOverAudioPlayed:
		$"audio/background gameplay".stop()
		$"audio/background game over".play()
		$"audio/lion end roar".play()
		gameOverAudioPlayed = true
	get_tree().paused = true
	$hud/ScoreTimer.stop()
	$lion/AnimatedSprite2D.stop()
	$hud/torchButton.hide()
	$hud/sprayButton.hide()
	$hud/hornButton.hide()
	$player/AnimatedSprite2D.stop()
	$hud/blackRect.show()
	$hud/gameOverPanel.show()
	get_tree().paused = false

func _on_hud_times_up():
	emit_signal("gameOver")
	gameOverAudioPlayed = true
	get_tree().paused = true
	$hud/ScoreTimer.stop()
	$lion/AnimatedSprite2D.stop()
	$player/AnimatedSprite2D.stop()
	$hud/torchButton.hide()
	$hud/sprayButton.hide()
	$hud/hornButton.hide()
	#$hud/blackRect.show()
	#$hud/gameOverPanel.show()
	get_tree().paused = false

var first_weapon = "none"
var second_weapon = "none"
var third_weapon = "none"

func reorganise_weapons(weapon: String):
	if (first_weapon == weapon):
		first_weapon = second_weapon
		second_weapon = third_weapon
		third_weapon = "none"
	elif (second_weapon == weapon):
		second_weapon = third_weapon
		third_weapon = "none"
	elif (third_weapon == weapon):
		third_weapon = "none"
	organise_weapons()

func index_weapons(weapon: String):
	if first_weapon == "none":
		first_weapon = weapon
	elif second_weapon == "none":
		second_weapon = weapon
	elif third_weapon == "none":
		third_weapon = weapon

func organise_individual_weapon(index: int, weapon: String):
	var buttonPos = Vector2(6923, 2654)
	buttonPos.x -= (index - 1) * 330
	var _button
	if (weapon == "torch"):
		_button = $hud/torchButton
	elif (weapon == "spray"):
		_button = $hud/sprayButton
	else:
		_button = $hud/hornButton
	_button.position = buttonPos
	_button.disabled = false
	_button.visible = true

func organise_weapons():
	if (first_weapon != "none"):
		organise_individual_weapon(1, first_weapon)
	if (second_weapon != "none"):
		organise_individual_weapon(2, second_weapon)
	if (third_weapon != "none"):
		organise_individual_weapon(3, third_weapon)
	#print_weapons()

func print_weapons():
	print_debug(" 1st weapon: ", first_weapon)
	print_debug(" 2nd weapon: ", second_weapon)
	print_debug(" 3rd weapon: ", third_weapon)

#torch is picked up
func _on_pick_up_torch_picked_up():
	#item disappears and collision is disabled
	get_node("weapons to pick up/pick up torch").queue_free()
	#set as which weapon
	index_weapons("torch")
	#make weapons buttons appear
	organise_weapons()

func _on_pick_up_spray_picked_up():
	get_node("weapons to pick up/pick up spray").queue_free()
	index_weapons("spray")
	organise_weapons()
	
func _on_pick_up_horn_picked_up():
	get_node("weapons to pick up/pick up horn").queue_free()
	index_weapons("horn")
	organise_weapons()

func _on_torch_button_pressed():
	$hud/torchButton.queue_free()
	reorganise_weapons("torch")

func _on_spray_button_pressed():
	await get_tree().create_timer(0.267).timeout
	$hud/sprayButton.queue_free()
	reorganise_weapons("spray")

func _on_horn_button_pressed():
	$hud/hornButton.queue_free()
	reorganise_weapons("horn")

