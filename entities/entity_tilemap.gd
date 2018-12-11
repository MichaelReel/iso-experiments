extends TileMap

func _ready():
	for tile in get_used_cells():
		var tile_id = get_cell(tile.x, tile.y)
		var name = get_tileset().tile_get_name(tile_id)
		var tscn = str("res://", name.replace("+", "/"), ".tscn")
		var node = load(tscn).instance()
		node.global_position = map_to_world(tile)
		
		# Check for X flipped tiles
		if is_cell_x_flipped(tile.x, tile.y) and node.has_method("flip_x"):
			node.flip_x()
		
		# Hack to fix odd map overlapping
		node.global_position.y += 1
		
		get_parent().call_deferred("add_child", node)
	queue_free()