extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$TabContainer/Weapons/ScrollContainer/GridContainer/spray/MarginContainer/TextureRect.hide()
	$TabContainer/Weapons/ScrollContainer/GridContainer/horn/MarginContainer/TextureRect.hide()
	$TabContainer/Weapons/ScrollContainer/GridContainer/torch/MarginContainer/TextureRect.hide()
	$SprayBuyButton.hide()
	$TorchBuyButton.hide()
	$HornBuyButton.hide()
	$ColorRect3.hide()
	if (Global.speedBoost == true):
		$"TabContainer/Power ups/ScrollContainer/GridContainer/speed boost description/BuyButton".queue_free()
	if (Global.biggerTagArea == true):
		$"TabContainer/Power ups/ScrollContainer/GridContainer/biggerTagArea description/BuyButton2".queue_free()
	if (Global.torch_collected == true):
		$TabContainer/Weapons/ScrollContainer/GridContainer/torch/MarginContainer/TextureRect.show()
		$TorchBuyButton.show()
		if (Global.torch_bought == true):
			$TorchBuyButton.hide()
			
	if (Global.spray_collected == true):
		$TabContainer/Weapons/ScrollContainer/GridContainer/spray/MarginContainer/TextureRect.show()
		$SprayBuyButton.show()
		if (Global.spray_bought == true):
			$SprayBuyButton.hide()
			
	if (Global.horn_collected == true):
		$TabContainer/Weapons/ScrollContainer/GridContainer/horn/MarginContainer/TextureRect.show()
		$HornBuyButton.show()
		if (Global.horn_bought == true):
			$HornBuyButton.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Coins.text = str(Global.coins)



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")


func _on_buy_button_pressed():
	if (Global.coins < 100):
		$ColorRect3.show()
		await get_tree().create_timer(3).timeout
		$ColorRect3.hide()
	else:
		Global.speedBoost = true
		Global.coins -= 100
		$"TabContainer/Power ups/ScrollContainer/GridContainer/speed boost description/BuyButton".queue_free()


func _on_buy_button_2_pressed():
	if (Global.coins < 100):
		$ColorRect3.show()
		await get_tree().create_timer(3).timeout
		$ColorRect3.hide()
	else:
		Global.biggerTagArea = true
		Global.coins -= 100
		$"TabContainer/Power ups/ScrollContainer/GridContainer/biggerTagArea description/BuyButton2".queue_free()


func _on_torch_buy_button_pressed():
	if (Global.torch_collected == true):
		if (Global.coins < 100):
			$ColorRect3.show()
			await get_tree().create_timer(3).timeout
			$ColorRect3.hide()
		else:
			Global.torch_bought = true
			$TorchBuyButton.queue_free()
			Global.coins -= 100
	if (Global.spray_collected == true):
		if (Global.coins < 100):
			$ColorRect3.show()
			await get_tree().create_timer(3).timeout
			$ColorRect3.hide()
		else:
			Global.spray_bought = true
			$SprayBuyButton.queue_free()
			Global.coins -= 100
	if (Global.horn_collected == true):
		if (Global.coins < 100):
			$ColorRect3.show()
			await get_tree().create_timer(3).timeout
			$ColorRect3.hide()
		else:
			Global.horn_bought = true
			$HornBuyButton.queue_free()
			Global.coins -= 100
