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
    "mid_mid"    :MID_MID,
    "mid_right"  :MID_RIGHT,
    "down_left"  :DOWN_LEFT,
    "down_mid"   :DOWN_MID,
    "down_right" :DOWN_RIGHT
}

var DIR = {
    UP_LEFT     :"up_left",
    UP_MID      :"up_mid",
    UP_RIGHT    :"up_right",
    MID_LEFT    :"mid_left",
    MID_MID     :"mid_mid",
    MID_RIGHT   :"mid_right",
    DOWN_LEFT   :"down_left",
    DOWN_MID    :"down_mid",
    DOWN_RIGHT  :"down_right"
}