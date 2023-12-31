extends CanvasLayer
signal pressed_tag
signal message_disappear
@onready var PauseMenu = $PauseMenu
var lionDistance: int
var isAllyTagged = false
var Coins = Global.coins
var hasSetLocation: bool = false
var location
var score = 60
signal times_up

#@onready var player_animation = get_parent().get_node("player")
#var score = 60


# Called when the node enters the scene tree for the first time.
func _ready():
	$blackRect.hide()
	$gameOverPanel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not hasSetLocation:
		location = Global.current_location
		hasSetLocation = true
	#print_debug("node: ", get_parent().get_node("/root/Global").get_path())
	if Input.is_action_pressed("ui_cancel"):
		PauseMenu.visible = true
		get_tree().paused = true
	$distanceToLion.text = str(lionDistance / 60, " m")

func _on_tag_button_pressed():
	$MessageTimer.start()
	if isAllyTagged == true:
		if (Global.current_location == "tutorial"):
			Global.level_unlocked = "clb"
		if (Global.current_location == "clb"):
			Global.level_unlocked = "pgp"
		$blackRect.show()
		$Tick.show()
		$ScoreTimer.stop()
		get_tree().paused = true
		$"audio/correct ally".play()
		await get_tree().create_timer(5).timeout
		Coins += score
		if (Global.tutorial == false):
			Global.coins = Coins
		Global.tutorial = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://start_menu.tscn")
	else:
		$"audio/wrong ally".play()
		$Cross.show()

func _on_message_timer_timeout():
	message_disappear.emit()

func _on_score_timer_timeout():
	score -= 1
	$Score.text = str(score)
	if score == 10:
		$AudioStreamPlayer.play()
	if score == 0:
		$Score.text = "times up!"
		$Coin.hide()
		$blackRect.show()
		get_tree().paused = false
		$gameOverPanel.show()
		emit_signal("times_up")


func _on_resume_button_pressed():
	PauseMenu.visible = false
	get_tree().paused = false

func _on_exit_button_pressed():
	Global.doSaveFile = true
	#$StartMenu.save_file()
	get_tree().quit()

func _on_pause_button_pressed():
	get_tree().paused = true
	PauseMenu.visible = true

func _on_quit_button_pressed():
	Global.doSaveFile = true
	#$StartMenu.save_file()
	get_tree().quit()

func _on_try_again_button_pressed():
	get_tree().reload_current_scene()

func _on_ally_ally_tagged(tagged):
	print_debug("Location: ", location)
	if location == "clb":
		isAllyTagged = tagged

func _on_backtohome_pressed():
	get_tree().paused = false
	Global.tutorial = false
	get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_home_button_pressed():
	get_tree().paused = false
	Global.tutorial = false
	get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_lion_lion_distance(distance):
	lionDistance = distance - 500

func _on_npc_2_npc_2_ally_tagged(tagged):
	print_debug("Location: ", location)
	if location == "pgp":
		isAllyTagged = tagged

func _on_tutorial_ally_tut_ally_tagged(tagged):
	print_debug("Location: ", location)
	if location == "tutorial":
		isAllyTagged = tagged
