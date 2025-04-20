extends RigidBody2D

func _ready():
	
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	
	var scale_factor = randf_range(0.3, 0.6)
	$AnimatedSprite2D.scale *= scale_factor
	$CollisionShape2D.scale *= scale_factor
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
