extends KinematicBody2D

export(float)  var MAX_HEALTH = 1.0
export(String) var FACTION = "ENEMY"
export(float)  var MOTION_SPEED = 0 # Pixels/second
export(float)  var KNOCK_SPEED = 250
export(float)  var DAMAGE = 0.0

var knock_motion = dir.MID_MID
var sprite_dir = "down_mid"

var health = MAX_HEALTH
var hitstun = 0

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
	health = min(MAX_HEALTH, health)
	if hitstun > 0.0:
		hitstun -= delta
	elif FACTION  == "ENEMY" && health <= 0:
		var drop = randi() % 3
		if drop == 0:
			instance_scene(preload("res://pickups/heart.tscn"))
		instance_scene(preload("res://toxic/toxic_death.tscn"))
		queue_free()

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

func instance_scene(scene):
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	if new_scene.has_method("set_dir"):
		new_scene.set_dir(sprite_dir)
	get_parent().add_child(new_scene)