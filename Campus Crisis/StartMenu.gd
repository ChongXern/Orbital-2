extends Node2D
var score
var Coins

func _ready():
	update_coins(Coins)
	#load_file()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_coins(Coins):
	$Coins.text = str(Global.coins)
	

func _on_clb_level_1_pressed():
	get_tree().change_scene_to_file("res://loading_scene.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://tutorial_world.tscn")


func _on_inventory_pressed():
	get_tree().change_scene_to_file("res://inventory.tscn")

'''var save_data = "user://save.data"

func save_file():
	var file = FileAccess.open(save_data, FileAccess.WRITE)

func load_file():
	var file = FileAccess.open(save_data, FileAccess.READ)
	if (file.file_exists(save_data)):
		var loaded_game_data = file.get_var()
		Global.speedBoost = file.speedBoost
		Global.biggerTagArea = file.biggerTagArea
		Global.torch_collected = file.torch_collected
		Global.horn_collected = file.horn_collected
		Global.spray_collected = file.spray_collected
		
		$Coins.text = Global.coins

func create_data():
	var dictionary = {
	"coins": Global.coins,
	"speedBoost": Global.speedBoost,
	"biggerTagArea": Global.biggerTagArea,
	"torch_collected": Global.torch_collected,
	"horn_collected": Global.horn_collected,
	"spray_collected": Global.spray_collected
	}
	return dictionary


func _on_save_pressed():
	save_file()


func _on_load_pressed():
	load_file()
'''
