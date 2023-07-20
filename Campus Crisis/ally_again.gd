extends Node2D
signal hit
signal exit
signal ally_tagged(tagged: bool)
@export var speed = 400
var hasSetLocation: bool = false
var location

func _ready():
	pass

func _process(delta):
	$AnimatedSprite2D.play()
	if not hasSetLocation:
		location = Global.current_location
		hasSetLocation = true
	#ally moves along the path
	get_parent().set_progress(get_parent().get_progress() + speed * delta)

func _on_body_entered(body):
	if location == "clb":
		ally_tagged.emit(true)
	hit.emit()


func _on_body_exited(body):
	exit.emit()
	print_debug("exit.emit()")
	


func _on_area_2d_body_entered(body):
	if (Global.biggerTagArea == true):
		ally_tagged.emit(true)
		hit.emit()
		print_debug("hit.emit()")
