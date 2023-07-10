extends Node2D
signal pgp_location

# Called when the node enters the scene tree for the first time.
func _ready():
	pgp_location.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
