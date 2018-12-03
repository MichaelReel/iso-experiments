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
	$open.visible = true
	# Remove obsticle
	$barrier.disabled = true

func close():
	# Change sprite
	$closed.visible = true
	$open.visible = false
	# Add obsticle
	$barrier.disabled = false
	