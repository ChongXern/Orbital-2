extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$timerLabel.hide()
	$allyToTag.hide()
	$tagLabel.hide()
	$lionDir.hide()
	$"pick up weapon".hide()
	$"use weapons".hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enter"):
		get_tree().paused = false
		$timerLabel.hide()
		$allyToTag.hide()
		$tagLabel.hide()
		$lionDir.hide()
		$"pick up weapon".hide()
		$"use weapons".hide()
		$instructions.hide()
		$ColorRect.hide()
		Global.count += 1
	
	if Global.count == 1:
		get_tree().paused = true
		$ColorRect.show()
		$timerLabel.show()

	
	if Global.count == 2:
		get_tree().paused = true
		$ColorRect.show()
		$allyToTag.show()
	
	if Global.count == 3:
		get_tree().paused = true
		$ColorRect.show()
		$lionDir.show()
	

func next():
	if Input.is_action_just_pressed("enter"):
		get_tree().paused = false
		$timerLabel.hide()
		$allyToTag.hide()
		$tagLabel.hide()
		$lionDir.hide()
		$"pick up weapon".hide()
		$"use weapons".hide()
		$instructions.hide()
		$ColorRect.hide()
