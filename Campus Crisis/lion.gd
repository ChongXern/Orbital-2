extends CharacterBody2D
@export var speed = 600
var isLionRunningAway = false
var lionDir = "none"
signal lionDistance(distance: int)
signal x_distance(distance: int)
var playerPos: Vector2 = Vector2.ZERO
signal playerKilled
var isGameOver: bool = false

func _on_player_player_pos(pos):
	playerPos = pos

func _physics_process(delta):
	if not isGameOver:
		#print_debug(playerPos)
		var distToLion = get_distance_to_player()
		if distToLion >= 406:
			lionDir == "left"
			$AnimatedSprite2D.flip_h = false
			#print_debug("left")
		elif distToLion < -114:
			lionDir == "right"
			$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("lion running")
		var targetPos = (position - playerPos).normalized()
		if isLionRunningAway:
			$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h 
			velocity = targetPos * 450
		else:
			if position.distance_to(playerPos) > 3:
				velocity = -targetPos * 525
		move_and_slide()
	if compute_pythagoras_distance() <= 500:
		playerKilled.emit()
	emit_signal("lionDistance", compute_pythagoras_distance())
	emit_signal("x_distance", get_distance_to_player())
	
func get_distance_to_player() -> int:
	return position.x - playerPos.x

func compute_pythagoras_distance() -> int:
	var xDiff = abs(position.x - playerPos.x)
	var yDiff = abs(position.y - playerPos.y)
	return int(sqrt(xDiff * xDiff + yDiff * yDiff))
	
func _on_torch_button_pressed():
	#emit_signal("lionDistance", get_distance_to_player())
	isLionRunningAway = true
	$AudioStreamPlayer.play()
	await get_tree().create_timer(3).timeout
	isLionRunningAway = false

func _on_spray_button_pressed():
	#emit_signal("lionDistance", get_distance_to_player())
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.267).timeout
	isLionRunningAway = true
	await get_tree().create_timer(2.733).timeout
	isLionRunningAway = false

func _on_horn_button_pressed():
	#emit_signal("lionDistance", get_distance_to_player())
	isLionRunningAway = true
	$AudioStreamPlayer.play()
	await get_tree().create_timer(3).timeout
	isLionRunningAway = false


func _on_world_pgp_3_game_over():
	isGameOver = true
