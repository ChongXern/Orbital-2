extends Area2D
signal hit
signal exit
@export var speed = 400
var isGameOver: bool = false

func _ready():
	pass

func _physics_process(delta):
	if not isGameOver:
		$AnimatedSprite2D.play()
		#npc moves along the path
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	else:
		$AnimatedSprite2D.stop()

func _on_body_entered(body):
	hit.emit()


func _on_body_exited(body):
	exit.emit()

func _on_game_over():
	isGameOver = true
