extends "res://entity/entity.gd"

# Member variables
const MOTION_SPEED = 100 # Pixels/second

var move_time = 0.0
var motion

func _physics_process(delta):
	update_motion(delta)
	update_animation(motion)
	perform_movement(motion)

func update_motion(delta):

	if is_on_wall():
		if test_move(transform, dir.ALL[sprite_dir]):
			move_time = 0.0

	if move_time > 0.0:
		move_time -= delta
	else:
		motion = dir.ALL.values()[randi() % len(dir.ALL)]
		move_time = rand_range(0.2, 3.0);

func update_animation(motion):
	var sprite_dir = update_sprite_anim_dir(motion)
	if motion != dir.MID_MID:
		set_animation("walk", sprite_dir)
	else:
		set_animation("idle", sprite_dir)
	