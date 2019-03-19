extends "res://engine/entity.gd"

# Member variables
func _init():
	MOTION_SPEED = 100 # Pixels/second
	FACTION = "PLAYER"

var move_time = 0.0
var motion

func _physics_process(delta):
	update_motion(delta)
	update_animation(motion)
	perform_movement(motion)
	update_damage(delta)

func update_motion(delta):

	if is_on_wall():
		if test_move(transform, dir.ALL[sprite_dir]):
			move_time = 0.0
			# alternatively we could do: motion = motion.tangent()
			# But this will cause the NPC to "spasm" when trapped,
			# rather than simply "protest" occasionally

	if move_time > 0.0:
		move_time -= delta
	else:
		motion = dir.rand_all()
		move_time = rand_range(0.2, 3.0);

func update_animation(motion):
	update_sprite_anim_dir(motion)
	if hitstun > 0.0:
		set_animation("hurt")
	elif motion != dir.MID_MID:
		set_animation("walk")
	else:
		set_animation("idle")
	