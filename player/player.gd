extends "res://engine/entity.gd"

# Member variables
const MOTION_SPEED = 100 # Pixels/second
const FACTION = "PLAYER"
const MAX_HEALTH = 16.0

var state = "default"
var keys = 0

func _physics_process(delta):
	match state:
		"default":
			state_default(delta)
		"swing":
			state_swing(delta)

	# Not sure why we'd waste time doing this:
	keys = min(keys, 9)

func state_default(delta):
	var motion = get_input_motion()
	update_animation(motion)
	perform_movement(motion)
	update_damage(delta)

func state_swing(delta):
	var motion = dir.MID_MID
	set_animation("idle")
	perform_movement(motion)
	update_damage(delta)

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
	update_sprite_anim_dir(motion)
	if hitstun > 0.0:
		set_animation("hurt")
	elif motion != dir.MID_MID:
		set_animation("walk")
	else:
		set_animation("idle")

	# TODO: Refactor this?:
	if Input.is_action_just_pressed("action_a"):
		use_item(preload("res://items/sword.tscn"))