extends Node

const   UP_LEFT  = Vector2(-1, -1)
const   UP_MID   = Vector2( 0, -1)
const   UP_RIGHT = Vector2( 1, -1)
const  MID_LEFT  = Vector2(-1,  0)
const  MID_MID   = Vector2( 0,  0)
const  MID_RIGHT = Vector2( 1,  0)
const DOWN_LEFT  = Vector2(-1,  1)
const DOWN_MID   = Vector2( 0,  1)
const DOWN_RIGHT = Vector2( 1,  1)

var ALL = {
	"up_left"    :UP_LEFT,
	"up_mid"     :UP_MID,
	"up_right"   :UP_RIGHT,
	"mid_left"   :MID_LEFT,
	"mid_right"  :MID_RIGHT,
	"down_left"  :DOWN_LEFT,
	"down_mid"   :DOWN_MID,
	"down_right" :DOWN_RIGHT,
	"mid_mid"    :MID_MID,
}

var DIR = {
	UP_LEFT     :"up_left",
	UP_MID      :"up_mid",
	UP_RIGHT    :"up_right",
	MID_LEFT    :"mid_left",
	MID_RIGHT   :"mid_right",
	DOWN_LEFT   :"down_left",
	DOWN_MID    :"down_mid",
	DOWN_RIGHT  :"down_right",
	MID_MID     :"mid_mid",
}

func rand_no_idle():
	# Return random moving direction
	return ALL.values()[randi() % 8]

func rand_all():
	# Return random direction
	return ALL.values()[randi() % len(ALL)]