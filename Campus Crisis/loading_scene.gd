extends Control
@export var scene:String = "res://world.tscn"
@onready var progress_bar:ProgressBar = $ProgressBar
var progress = []
var scene_load_status = 0

func _ready():
	if (Global.load_scene == "tutorial"):
		scene = "res://tutorial_world.tscn"
	if (Global.load_scene == "clb"):
		scene = "res://world.tscn"
	if (Global.load_scene == "pgp"):
		scene = "res://world_pgp_3.tscn"
	ResourceLoader.load_threaded_request(scene)
	$AnimatedSprite2D.play()


func _process(delta):
	while scene_load_status != 1:
		await get_tree().create_timer(0.5).timeout
		scene_load_status += 0.125
		progress_bar.value += 12.5
	if scene_load_status == 1:
		get_tree().change_scene_to_file(scene)
		queue_free()
