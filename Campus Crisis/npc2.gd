extends Area2D
signal hit
signal exit
signal npc2_ally_tagged(tagged: bool)
@export var speed = 400
var hasSetLocation: bool = false
var location
var isGameOver: bool = false
#ally for pioneer house

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
	#print_debug(location)

func _on_body_entered(body):
	if location == "pgp":
		npc2_ally_tagged.emit(true)
	hit.emit()

func _on_body_exited(body):
	if location == "pgp":
		npc2_ally_tagged.emit(false)
	exit.emit()

func _on_game_over():
	isGameOver = true

func _on_area_2d_body_entered(body):
	if (Global.biggerTagArea == true):
		npc2_ally_tagged.emit(true)
		hit.emit()
		print_debug("hit.emit()")
