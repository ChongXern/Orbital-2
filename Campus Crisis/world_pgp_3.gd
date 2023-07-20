extends Node2D
var score
signal gameOver
#new ally is npc2

# Called when the node enters the scene tree for the first time.
func _ready():
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
	score = 60


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
	#Global.isPaused = true
	emit_signal("gameOver")
	get_tree().paused = true
	$hud/ScoreTimer.stop()
	$lion/AnimatedSprite2D.stop()
	$player/AnimatedSprite2D.stop()
	$hud/blackRect.show()
	$hud/gameOverPanel.show()
	get_tree().paused = false
	#Global.isPaused = false
