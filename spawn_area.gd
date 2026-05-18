"""
extends CollisionShape2D

@export var banan_scene: PackedScene
@export var spawn_count := 5

func _ready() -> void:
	for i in spawn_count:
		spawn_banan()

func spawn_banan():
	var shape := $CollisionShape2D.shape 
	var rect := shape.get_rect()
	
	var pos := Vector2(
		randf_range(rect.position.x, rect.position.x + rect.size.x),
		randf_range(rect.position.y, rect.position.y + rect.size.y))
	var collectable := banan_scene.instantiate()
	collectable.global_position = global_position + pos
	get_parent().add_child(collectable)

"""
