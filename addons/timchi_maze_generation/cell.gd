class_name Cell

var location := Vector2i(0,0)

var north := false
var south := false
var east := false
var west := false

const DEAD_END := 1
const HALLWAY := 2
const CORNER := 4
const JUNCTION := 8
const ALL_WAY := 16

func _init(x, y):
	location.x = x
	location.y = y

func visited() -> bool:
	return north || south || east || west
	
func get_type() -> int:
	var r = 0
	for x in [north, south, east, west]:
		if x:
			r += 1
	
	match r:
		1: return DEAD_END
		2 when ((north && south) || (east && west)): return HALLWAY
		2: return CORNER
		3: return JUNCTION
		_: return ALL_WAY
	
func get_rotation() -> float:
	var openings = [north, east, south, west]
	
	match openings:
		# Dead end
		[true, false, false, false]: return deg_to_rad(180)
		[false, true, false, false]: return deg_to_rad(90)
		[false, false, true, false]: return deg_to_rad(0)
		[false, false, false, true]: return deg_to_rad(270)
		# Hallway
		[true, false, true, false]: return deg_to_rad(0)
		[false, true, false, true]: return deg_to_rad(90)
		# Corner
		[true, true, false, false]: return deg_to_rad(180)
		[false, true, true, false]: return deg_to_rad(90)
		[false, false, true, true]: return deg_to_rad(0)
		[true, false, false, true]: return deg_to_rad(270)
		# Junction
		[false, true, true, true]: return deg_to_rad(0)
		[true, true, true, false]: return deg_to_rad(90)
		[true, true, false, true]: return deg_to_rad(180)
		[true, false, true, true]: return deg_to_rad(270)
		# Default, handles the allways with no rotation.
		_: return deg_to_rad(0)
	

