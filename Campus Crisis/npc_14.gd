extends Area2D
signal hit
signal exit
@export var speed = 400

func _ready():
	pass

func _physics_process(delta):
	$AnimatedSprite2D.play()
	#npc moves along the path
	if not Global.isPaused:
		print_debug("playing")
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	else:
		print_debug("paused")

func _on_body_entered(body):
	hit.emit()


func _on_body_exited(body):
	exit.emit()
