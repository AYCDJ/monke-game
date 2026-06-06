extends Node

@export var mob_scene: PackedScene
var score
var banana_score = 0
@export var banan_scene: PackedScene 
var banana: Area2D
var game_time := 0.0
@export var cool_monkey_scene: PackedScene
var cool_monkey: Area2D

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$GameOver.play()

func new_game():
	score = 0 
	banana_score = 0
	game_time = 0.0
	$HUD.update_banana_score(banana_score)
	$Music.play()
	Settings.difficulty = "easy" # remove/change this eventually - forces easy 
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
	
	var cycle_time = score % 60
	
	if cycle_time == 5 or cycle_time == 15 or cycle_time == 30:
		spawn_cool_monkey()

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func spawn_banan():
	if banana:
		banana.queue_free()
	
	banana = banan_scene.instantiate()
	
	
	banana.collected.connect(_on_banana_collected)
	
	add_child(banana)

func _on_banana_collected():
	banana_score += 1
	print("collected banan: ", banana_score)
	$HUD.update_banana_score(banana_score)
	$BananTimer.start()

func _on_banan_timer_timeout():
	spawn_banan()

func spawn_cool_monkey():
	if is_instance_valid(cool_monkey):
		cool_monkey.queue_free()
	
	cool_monkey = cool_monkey_scene.instantiate()
	
	add_child(cool_monkey)
	
	cool_monkey.respawn()
