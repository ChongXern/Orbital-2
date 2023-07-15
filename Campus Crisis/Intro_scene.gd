extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_location = "intro"
	$AnimationPlayer.play("black_screen")
	await get_tree().create_timer(6).timeout
	$AnimationPlayer.play("black_out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://start_menu.tscn")
