extends Node2D

var FACTION = null
const DAMAGE = 0.5

var max_amount = 1

func _ready():
	var parent = get_parent()
	FACTION = parent.FACTION
	$anim.connect("animation_finished", self, "destroy")
	$anim.play(str("swing_", parent.sprite_dir))
	if parent.has_method("state_swing"):
		parent.state = "swing"

func destroy(animation):
	var parent = get_parent()
	if parent.has_method("state_swing"):
		parent.state = "default"
	queue_free()