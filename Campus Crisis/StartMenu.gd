extends Node2D
var score
var Coins

func _ready():
	update_coins(Coins)
	$levels/ColorRect.hide()
	$levels/ScrollContainer/VBoxContainer/clb_tilemap.hide()
	$levels/ScrollContainer/VBoxContainer/pgp_tilemap.hide()
	if (Global.level_unlocked == "clb" or Global.level_unlocked == "pgp"):
		$levels/ScrollContainer/VBoxContainer/clb_tilemap.show()
		$levels/ScrollContainer/VBoxContainer/clb_lock.hide()
	if (Global.level_unlocked == "pgp"):
		$levels/ScrollContainer/VBoxContainer/pgp_tilemap.show()
		$levels/ScrollContainer/VBoxContainer/pgp_lock.hide()
	if (Global.justentered == true):
		load_file()
		Global.justentered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.doSaveFile:
		save_file()
		print_debug("Saved file")

func update_coins(Coins):
	$Coins.text = str(Global.coins)

func _on_pgp_pressed():
	if (Global.level_unlocked != "pgp"):
		$levels/ColorRect.show()
		await get_tree().create_timer(3).timeout
		$levels/ColorRect.hide()
	else:
		Global.load_scene = "pgp"
		get_tree().change_scene_to_file("res://loading_scene.tscn")

func _on_clb_level_1_pressed():
	if (Global.level_unlocked == "tutorial"):
		$levels/ColorRect.show()
		await get_tree().create_timer(3).timeout
		$levels/ColorRect.hide()
	else:
		Global.load_scene = "clb"
		get_tree().change_scene_to_file("res://loading_scene.tscn")


func _on_tutorial_pressed():
	Global.load_scene = "tutorial"
	get_tree().change_scene_to_file("res://loading_scene.tscn")


func _on_inventory_pressed():
	get_tree().change_scene_to_file("res://inventory.tscn")

var save_data = "user://save.data"

func save_file():
	var file = FileAccess.open(save_data, FileAccess.WRITE)
	var data = create_data()
	file.store_var(data)

func load_file():
	var file = FileAccess.open(save_data, FileAccess.READ)
	if (FileAccess.file_exists(save_data)):
		var loaded_game_data = file.get_var()
		Global.speedBoost = loaded_game_data.speedBoost
		Global.biggerTagArea = loaded_game_data.biggerTagArea
		Global.torch_collected = loaded_game_data.torch_collected
		Global.horn_collected = loaded_game_data.horn_collected
		Global.spray_collected = loaded_game_data.spray_collected
		Global.torch_bought = loaded_game_data.torch_bought
		Global.spray_bought = loaded_game_data.spray_bought
		Global.horn_bought = loaded_game_data.horn_bought
		Global.coins = loaded_game_data.coins
		#Global.level_unlocked = loaded_game_data.level_unlocked
		$Coins.text = str(Global.coins)

func create_data():
	var dictionary = {
	"coins": Global.coins,
	"speedBoost": Global.speedBoost,
	"biggerTagArea": Global.biggerTagArea,
	"torch_collected": Global.torch_collected,
	"horn_collected": Global.horn_collected,
	"spray_collected": Global.spray_collected,
	"torch_bought": Global.torch_bought,
	"horn_bought": Global.horn_bought,
	"spray_bought": Global.spray_bought,
	"level_unlocked": Global.level_unlocked
	}
	return dictionary


func _on_save_pressed():
	save_file()
	get_tree().quit()




