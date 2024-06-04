@icon("res://addons/timchi_maze_generation/maze.svg")
@tool
class_name Maze3D
extends GridMap

@export_group("Maze")
@export_range(1, 100, 1, "or_greater") var maze_width := 20:
	set(value): maze_width = value; draw_maze()
				
@export_range(1, 100, 1, "or_greater")  var maze_height := 20:
	set(value): maze_height = value; draw_maze()
	
@export_range(0.0, 1.0, 0.05) var linearity := 0.75:
	set(value): linearity = value; draw_maze()
	
@export var seed := 0:
	set(value): seed = value; draw_maze()
@export var generate_navmesh := true

@export_group("Cell")
@export var dead_end:int
@export var hallway:int
@export var corner:int
@export var junction:int
@export var all_way:int

@export_group("Mesh Library")
@export var mesh_adjust:Basis
@export_range(0, 270, 90) var rotation_adjustment:int

@onready var maze:Maze = Maze.new(maze_width, maze_height, linearity, seed)

func draw_maze():
	maze = Maze.new(maze_width, maze_height, linearity, seed)
	maze.generate_maze()
	
	if mesh_library == null || $Navigation == null:
		return
		
	clear()
	
	for item:Vector2i in maze.maze:
		var mi = maze.maze[item]
		var t = mi.get_type()
		var ct = 0
		match t:
			Cell.DEAD_END: ct = dead_end
			Cell.CORNER: ct = corner
			Cell.HALLWAY: ct = hallway
			Cell.JUNCTION: ct = junction
			_: ct = all_way
		var oi = get_orthogonal_index_from_basis(Basis(Vector3.UP, mi.get_rotation() + deg_to_rad(rotation_adjustment)))
		set_cell_item(Vector3i(mi.location.x, 0, mi.location.y), ct, oi)
	
	if generate_navmesh:	
		$Navigation.bake_navigation_mesh()
	else:
		$Navigation.navigation_mesh.clear()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	draw_maze()
	add_to_group("timchi_maze")
