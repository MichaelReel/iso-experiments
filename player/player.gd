extends "res://entity/entity.gd"

# Member variables
const MOTION_SPEED = 100 # Pixels/second

func _physics_process(delta):
	var motion = get_input_motion()
	update_animation(motion)
	perform_movement(motion)

func get_input_motion():
	"""
	Returns unnormalised motion vector
	"""
	var motion = dir.MID_MID
	
	if Input.is_action_pressed("move_up"):
		motion += dir.UP_MID
	if Input.is_action_pressed("move_bottom"):
		motion += dir.DOWN_MID
	if Input.is_action_pressed("move_left"):
		motion += dir.MID_LEFT
	if Input.is_action_pressed("move_right"):
		motion += dir.MID_RIGHT
	return motion

func update_animation(motion):
	var sprite_dir = update_sprite_anim_dir(motion)
	if motion != dir.MID_MID:
		set_animation("walk", sprite_dir)
	else:
		set_animation("idle", sprite_dir)