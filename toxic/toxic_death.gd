extends Node2D

var sprite_dir = "down_left"

func init(dir):
	sprite_dir = dir

func _ready():
	$anim.play(sprite_dir)
	$anim.connect("animation_finished", self, "destroy")

func destroy(animation):
	queue_free()