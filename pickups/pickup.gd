extends Area2D

export (bool) var disappears = false # Disappears when colliding with the player
export (float) var time_out = 0      # Timeout until disappears

func _ready():
	connect("body_entered", self, "body_entered")
	connect("area_entered", self, "area_entered")
	
	if disappears:
		var timer = Timer.new()
		timer.set_wait_time(time_out)
		timer.connect("timeout", self, "on_timeout")
		add_child(timer)
		timer.start()

func area_entered(area):
	""" Call body entered on parent, so weapons can activate collision """
	var area_parent = area.get_parent()
	if area_parent.name == "sword":
		body_entered(area_parent.get_parent())

func on_timeout():
	# TODO: Fade animation?
	queue_free()