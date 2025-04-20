extends Node

@export var mob_scene: PackedScene
@export var mob_timer: float

var score
var screen_size

func new_game():
	score = 0
	$MobTimer.wait_time = mob_timer
	
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	$Music.play()
	
	get_tree().call_group("mobs", "queue_free")


func game_over() -> void:
	$Music.stop()
	$DeathSound.play()
	
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.game_over(score)

func _ready():
	screen_size = get_viewport().size
	
	
func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_location = $MobPath/MobSpawnLocation
	
	mob_location.progress_ratio = randf()
	mob.position = mob_location.position
	
	var mob_direction = mob_location.rotation + PI / 2
	mob_direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = mob_direction
	
	var mob_velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = mob_velocity.rotated(mob_direction)
	
	add_child(mob)
	
	


func _on_score_timer_timeout() -> void:
	score += 1
	
	$MobTimer.wait_time = mob_timer / max(int(score / 10), 1)
	
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
