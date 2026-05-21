extends Area2D

@export var screen_margin := 64

signal collected

func _ready():
	randomize()
	respawn()

func respawn():
	var screen_size = get_viewport().get_visible_rect().size
	
	global_position = Vector2(
		randf_range(screen_margin, screen_size.x - screen_margin),
		randf_range(screen_margin, screen_size.y - screen_margin)
	)

'''
func _on_body_entered(body):
	if body.name == "Player":
		print("Touched :", body.name)
		respawn()
'''

func _on_area_entered(area):
	if area.name == "Player":
		collected.emit()
		queue_free()
