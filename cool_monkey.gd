extends Area2D

@export var screen_margin := 32

signal collected

func _ready():
	randomize()
	respawn()
	$Timer.wait_time = Settings.get_monkey_lifetime()
	$Timer.start()

func respawn():
	var screen_size = get_viewport().get_visible_rect().size
	
	global_position = Vector2(
		randf_range(screen_margin, screen_size.x - screen_margin),
		randf_range(screen_margin, screen_size.y - screen_margin)
	)


func _on_area_entered(area):
	if area.name == "Player":
		collected.emit()
		queue_free()


func _on_timer_timeout():
	queue_free()
