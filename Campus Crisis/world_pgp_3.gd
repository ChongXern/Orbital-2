extends Node2D
var score
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
	pass

func _on_ally_exit():
	$hud/TagButton.hide()

func _on_ally_hit():
	$hud/TagButton.show()
