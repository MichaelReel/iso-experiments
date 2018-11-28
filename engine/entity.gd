extends KinematicBody2D

# Member variables
const MOTION_SPEED = 0 # Pixels/second
const KNOCK_SPEED = 250
const FACTION = "ENEMY"
const DAMAGE = 0.0

var sprite_dir = "down_mid"

var knock_motion = dir.MID_MID
var hitstun = 0

var health = 1.0


func set_animation(animation):
	var animation_name = str(animation, "_", sprite_dir)
	if $anim.current_animation != animation_name:
		$anim.play(animation_name)
	
func perform_movement(motion):
	var norm_motion = dir.MID_MID
	if hitstun <= 0.0:
		norm_motion = motion.normalized() * MOTION_SPEED
	else:
		norm_motion = knock_motion.normalized() * KNOCK_SPEED
	# Adjust movement for isometric
	norm_motion.y *= 0.5
	move_and_slide(norm_motion)

func update_sprite_anim_dir(motion):
	"""
	Takes un-normalised motion vector
	Updates sprite_dir animation string in format <vert>_<hortz>
	where <vert> is up, mid or down and <hortz> is left, mid or right
	defaults to the already current one on mid_mid (no motion)
	"""
	if motion != dir.MID_MID:
		sprite_dir = dir.DIR[motion]

func update_damage(delta):
	if hitstun > 0.0:
		hitstun -= delta

	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		var other_damage = body.get("DAMAGE")
		var other_faction = body.get("FACTION")
		if hitstun <= 0.0 and other_damage != null and other_faction != self.FACTION:
			health -= other_damage
			hitstun = 0.25
			knock_motion = self.global_transform.origin - body.global_transform.origin

func use_item(item):
	var new_item = item.instance()
	var group_name = str(new_item.get_name(), self)
	new_item.add_to_group(group_name)
	add_child(new_item)
	if get_tree().get_nodes_in_group(group_name).size() > new_item.max_amount:
		new_item.queue_free()