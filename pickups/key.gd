extends Area2D

const MAX_KEYS = 9

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	# Limit the keys
	if body.name == "player" and body.get("keys") < MAX_KEYS:
		body.keys += 1
		queue_free()