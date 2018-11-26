extends Node2D

var FACTION = null
const DAMAGE = 1

var max_amount = 1

func _ready():
	FACTION = get_parent().FACTION
	$anim.connect("animation_finished", self, "destroy")
	$anim.play(str("swing_", get_parent().sprite_dir))

func destroy(animation):
	queue_free()