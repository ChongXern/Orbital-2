extends Area2D
signal picked_up
signal tutorial_instruction
var weaponUsed = false

func _ready():
	$"spinning star".play("spinning star thing")

func _on_body_entered(body):
	if not weaponUsed:
		print_debug("spray picked up")
		queue_free()
		weaponUsed = true
		picked_up.emit()

func _on_area_2d_body_entered(body):
	tutorial_instruction.emit()
