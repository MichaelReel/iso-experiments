extends "res://entity/entity.gd"

# Member variables
const MOTION_SPEED = 100 # Pixels/second

var sprite_dir = "down_mid"

func _physics_process(delta):
	var motion = get_input_motion()
	update_animation(motion)
	perform_movement(motion)

func update_animation(motion):
	sprite_dir = get_sprite_anim_dir(motion, sprite_dir)
	if motion != Vector2(0,0):
		set_animation("walk", sprite_dir)
	else:
		set_animation("idle", sprite_dir)