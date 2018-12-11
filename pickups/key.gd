extends "res://pickups/pickup.gd"

const MAX_KEYS = 9

func body_entered(body):
	# Limit the keys
	if body.name == "player" and body.get("keys") < MAX_KEYS:
		body.keys += 1
		queue_free()