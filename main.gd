extends Node

@export var mob_scene: PackedScene
var score
@export var banan_scene: PackedScene 
var banana: Area2D

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$GameOver.play()

func new_game():
	score = 0
	$Music.play()
	$Player.start($StartPostition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	spawn_banan()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	#random location on path
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	#mob position and direction perpendicular to path
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI / 2
	
	#random direction and speed 
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

#func _ready():
	#new_game()

func spawn_banan():
	if banana:
		banana.queue_free()
	
	banana = banan_scene.instantiate()
	
	var spawn_points = $BananSpawnArea.get_children()
	var spawn = spawn_points.pick_random()
	
	banana.position = spawn.global_position
	banana.collected.connect(_on_banana_collected)
	
	add_child(banana)

func _on_banana_collected():
	$BananTimer.start()

func _on_banan_timer_timeout():
	spawn_banan()
