extends Area2D

export (bool) var disappears = false # Disappears when colliding with the player

func _ready():
	connect("body_entered", self, "body_entered")
	connect("area_entered", self, "area_entered")

func area_entered(area):
	""" Call body entered on parent, so weapons can activate collision """
	var area_parent = area.get_parent()
	if area_parent.name == "sword":
		body_entered(area_parent.get_parent())
