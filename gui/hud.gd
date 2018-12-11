extends CanvasLayer

onready var player = get_node("../player")

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 20
const HEART_PORTIONS = 4 # This should match the top frame index on the heart sprite

func _ready():
	for i in player.MAX_HEALTH:
		var new_heart = Sprite.new()
		new_heart.texture = $hearts.texture
		new_heart.hframes = $hearts.hframes
		$hearts.add_child(new_heart)

func _process(delta):
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		
		var last_heart = floor(player.health)
		if index > last_heart:
			heart.frame = 0
		elif index == last_heart:
			heart.frame = (player.health - last_heart) * HEART_PORTIONS
		elif index < last_heart:
			heart.frame = HEART_PORTIONS
	
	$keys.frame = player.keys