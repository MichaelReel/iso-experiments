extends TileMap

func _ready():
	for tile in get_used_cells():
		var tile_id = get_cell(tile.x, tile.y)
		var name = get_tileset().tile_get_name(tile_id)
		var tscn = str("res://", name.replace("_", "/"), ".tscn")
		var node = load(tscn).instance()
		node.global_position = map_to_world(tile)
		get_parent().call_deferred("add_child", node)
	queue_free()