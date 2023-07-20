extends Area2D
signal hit
signal exit
signal npc2_ally_tagged(tagged: bool)
@export var speed = 400
var hasSetLocation: bool = false
var location
#ally for pioneer house

func _ready():
	pass

func _physics_process(delta):
	$AnimatedSprite2D.play()
	if not hasSetLocation:
		location = Global.current_location
		hasSetLocation = true
	#npc moves along the path
	if not Global.isPaused:
		get_parent().set_progress(get_parent().get_progress() + speed * delta)

func _on_body_entered(body):
	if location == "pgp":
		npc2_ally_tagged.emit(true)
	hit.emit()

func _on_body_exited(body):
	exit.emit()
