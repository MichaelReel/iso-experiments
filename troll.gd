extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 100 # Pixels/second

var sprite_dir = "down_mid"

func _physics_process(delta):
	var motion = get_input_motion()
	sprite_dir = get_sprite_anim_dir(motion)
	var animation_name = str("idle_", sprite_dir)
	if motion != Vector2(0,0):
		animation_name = str("walk_", sprite_dir)
	if $anim.current_animation != animation_name:
		$anim.play(animation_name)
	
	var norm_motion = motion.normalized() * MOTION_SPEED
	norm_motion.y *= 0.5 # Perform movement isometrically
	move_and_slide(norm_motion)

func get_input_motion():
	"""
	Returns unnormalised motion vector
	"""
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_bottom"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
	return motion

func get_sprite_anim_dir(motion):
	"""
	Takes un-normalised motion vector
	Returns animation string in format <vert>_<hortz>
	where <vert> is up, mid or down and <hortz> is left, mid or right
	"""

	match motion:
		Vector2(-1, -1):
			return "up_left"
		Vector2( 0, -1):
			return "up_mid"
		Vector2( 1, -1):
			return "up_right"
		Vector2(-1,  0):
			return "mid_left"
		Vector2( 1,  0):
			return "mid_right"
		Vector2(-1,  1):
			return "down_left"
		Vector2( 0,  1):
			return "down_mid"
		Vector2( 1,  1):
			return "down_right"

	# Otherwise, use the current direction
	return sprite_dir