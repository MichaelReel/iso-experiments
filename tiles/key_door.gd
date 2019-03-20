extends StaticBody2D

func _ready():
	$area.connect("body_entered", self, "body_entered")
	close()
	
func body_entered(body):
	if body.name == "player" && body.get("keys") > 0 && $closed.visible == true:
		body.keys -= 1
		open()

func open():
	# Change sprite
	$closed.visible = false
	$open_01.visible = true
	$open_02.visible = true
	# Remove obstacle
#   # Would prefer the door could be locked again, but disable isn't working
#	$barrier.disabled = true
#	$area/unlock_pad.disabled = true

	$barrier.free()
	$area/unlock_pad.free()

func close():
	# Change sprite
	$closed.visible = true
	$open_01.visible = false
	$open_02.visible = false
	# Add obstacle - This will fail if door previously closed
	$barrier.disabled = false
	$area/unlock_pad.disabled = false

func flip_x():
	# Don't flip twice (no undo either)
	if $closed.flip_h: return
	
	# Flip sprites and collisions, should only happen once
	$closed.set_flip_h(true)
	$open_01.set_flip_h(true)
	$open_02.set_flip_h(true)
	
	flip_x_collision($barrier)
	flip_x_collision($area/unlock_pad)

func flip_x_collision(collider):
	collider
	var poly = PoolVector2Array()
	for vect in collider.get_polygon():
		poly.append(Vector2(-vect.x, vect.y))
	
	collider.set_polygon(poly)