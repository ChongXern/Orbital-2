extends Node2D
signal hit
signal exit
signal tut_ally_tagged(tagged: bool)
@export var speed = 400
var hasSetLocation: bool = false
var location
var isGameOver: bool = false

func _ready():
	pass

func _physics_process(delta):
	if not hasSetLocation:
		location = Global.current_location
		hasSetLocation = true
	if not isGameOver:
		$AnimatedSprite2D.play()
		#npc moves along the path
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	else:
		$AnimatedSprite2D.stop()

func _on_body_entered(body):
	if location == "tut":
		tut_ally_tagged.emit(true)
	hit.emit()

func _on_body_exited(body):
	exit.emit()

func _on_tutorial_world_game_over():
	isGameOver = true
