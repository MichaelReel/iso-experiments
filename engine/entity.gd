extends KinematicBody2D

# Member variables
const MOTION_SPEED = 0 # Pixels/second
var sprite_dir = "down_mid"

func set_animation(animation, sprite_dir):
	var animation_name = str(animation, "_", sprite_dir)
	if $anim.current_animation != animation_name:
		$anim.play(animation_name)
	
func perform_movement(motion):
	var norm_motion = motion.normalized() * MOTION_SPEED
	# Adjust movement for isometric
	norm_motion.y *= 0.5
	move_and_slide(norm_motion)

func update_sprite_anim_dir(motion):
	"""
	Takes un-normalised motion vector
	Returns animation string in format <vert>_<hortz>
	where <vert> is up, mid or down and <hortz> is left, mid or right
	"""

	match motion:
		Vector2(-1, -1):
			sprite_dir = "up_left"
		Vector2( 0, -1):
			sprite_dir = "up_mid"
		Vector2( 1, -1):
			sprite_dir = "up_right"
		Vector2(-1,  0):
			sprite_dir = "mid_left"
		Vector2( 1,  0):
			sprite_dir = "mid_right"
		Vector2(-1,  1):
			sprite_dir = "down_left"
		Vector2( 0,  1):
			sprite_dir = "down_mid"
		Vector2( 1,  1):
			sprite_dir = "down_right"

	# Otherwise, use the current direction
	return sprite_dir