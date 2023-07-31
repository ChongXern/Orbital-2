extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_location = "inventory"
	$Coins.text = str(Global.coins)
	$TabContainer/Weapons/ScrollContainer/GridContainer/spray/MarginContainer/TextureRect.hide()
	$TabContainer/Weapons/ScrollContainer/GridContainer/horn/MarginContainer/TextureRect.hide()
	$TabContainer/Weapons/ScrollContainer/GridContainer/torch/MarginContainer/TextureRect.hide()
	$TabContainer/Weapons/SprayBuyButton.hide()
	$TabContainer/Weapons/TorchBuyButton.hide()
	$TabContainer/Weapons/HornBuyButton.hide()
	$ColorRect3.hide()
	if (Global.speedBoost == true):
		$"TabContainer/Power ups/ScrollContainer/GridContainer/speed boost description/BuyButton".queue_free()
	if (Global.biggerTagArea == true):
		$"TabContainer/Power ups/ScrollContainer/GridContainer/biggerTagArea description/BuyButton2".queue_free()
	if (Global.torch_collected == true):
		print_debug("torch collected")
		$TabContainer/Weapons/ScrollContainer/GridContainer/torch/MarginContainer/TextureRect.show()
		$TabContainer/Weapons/TorchBuyButton.show()
		if (Global.torch_bought == true):
			$TabContainer/Weapons/TorchBuyButton.hide()
	if (Global.spray_collected == true):
		print_debug("spray collected")
		$TabContainer/Weapons/ScrollContainer/GridContainer/spray/MarginContainer/TextureRect.show()
		$TabContainer/Weapons/SprayBuyButton.show()
		if (Global.spray_bought == true):
			$TabContainer/Weapons/SprayBuyButton.hide()
	if (Global.horn_collected == true):
		print_debug("horn collected")
		$TabContainer/Weapons/ScrollContainer/GridContainer/horn/MarginContainer/TextureRect.show()
		$TabContainer/Weapons/HornBuyButton.show()
		if (Global.horn_bought == true):
			$TabContainer/Weapons/HornBuyButton.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Coins.text = str(Global.coins)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_buy_button_pressed():
	if (Global.coins < 100):
		$ColorRect3.show()
		$audio/access_denied.play()
		await get_tree().create_timer(3).timeout
		$ColorRect3.hide()
	else:
		Global.speedBoost = true
		Global.coins -= 100
		$audio/ka_ching.play()
		$"TabContainer/Power ups/ScrollContainer/GridContainer/speed boost description/BuyButton".queue_free()

func _on_buy_button_2_pressed():
	if (Global.coins < 200):
		$ColorRect3.show()
		$audio/access_denied.play()
		await get_tree().create_timer(3).timeout
		$ColorRect3.hide()
	else:
		Global.biggerTagArea = true
		Global.coins -= 200
		$audio/ka_ching.play()
		$"TabContainer/Power ups/ScrollContainer/GridContainer/biggerTagArea description/BuyButton2".queue_free()

func _on_torch_buy_button_pressed():
	if (Global.torch_collected == true):
		if (Global.coins < 100):
			$ColorRect3.show()
			$audio/access_denied.play()
			await get_tree().create_timer(3).timeout
			$ColorRect3.hide()
		else:
			Global.torch_bought = true
			$TabContainer/Weapons/TorchBuyButton.queue_free()
			Global.coins -= 100
			$audio/ka_ching.play()
	if (Global.spray_collected == true):
		if (Global.coins < 200):
			$ColorRect3.show()
			$audio/access_denied.play()
			await get_tree().create_timer(3).timeout
			$ColorRect3.hide()
		else:
			Global.spray_bought = true
			$TabContainer/Weapons/SprayBuyButton.queue_free()
			Global.coins -= 200
			$audio/ka_ching.play()
	if (Global.horn_collected == true):
		if (Global.coins < 300):
			$ColorRect3.show()
			$audio/access_denied.play()
			await get_tree().create_timer(3).timeout
			$ColorRect3.hide()
		else:
			Global.horn_bought = true
			$TabContainer/Weapons/HornBuyButton.queue_free()
			Global.coins -= 300
			$audio/ka_ching.play()
