class_name Maze

var maze = {}
var maze_width:int
var maze_height:int
var linearity:float
var seed:int

var cells = []

var maze_created := false

func _init(width:int, height:int, l:float, s:int):
	maze_width = width
	maze_height = height
	linearity = l
	seed = s

func has_unvisited_neighbor(cell:Cell) -> bool:
	var l = cell.location
	

	if (l.x - 1) >= 0 && !maze[Vector2i(l.x-1, l.y)].visited():
		return true

	if (l.x + 1) < maze_width && !maze[Vector2i(l.x+1, l.y)].visited():
		return true

	if (l.y - 1) >= 0 && !maze[Vector2i(l.x, l.y-1)].visited():
		return true

	if (l.y + 1) < maze_height && !maze[Vector2i(l.x, l.y+1)].visited():
		return true

	return false
	
func in_bounds(a:Vector2i, b:Vector2i) -> bool:
	var r = a + b
	
	if r.x >= 0 && r.x < maze_width && r.y >= 0 &&  r.y < maze_height:
		return true
	return false
	
func get_unvisited_neighbor(cell:Cell) -> Cell:
	var option = [Vector2i(0, -1),Vector2i(0, 1),Vector2i(-1, 0),Vector2i(1, 0)]
	option.shuffle()
	
	for pick in option:
		if in_bounds(pick, cell.location) && !maze[(cell.location+pick)].visited():
			return maze[(cell.location+pick)]
	
	return null
		
	
func generate_maze():
	seed(seed)
	for x in maze_width:
		for y in maze_height:
			var c := Cell.new(x, y)
			maze[c.location] = c
			
	var x = randi_range(0, maze_width-1)
	var y = randi_range(0, maze_height-1)
	
	cells.append(maze[Vector2i(x, y)])
	
	while cells.size() > 0:
		var working_cell:Cell
		var roll = randf()
		var ri:int
		
		if roll > linearity: #Prims
			ri = randi_range(0, cells.size()-1)
		else:
			ri = cells.size()-1
		working_cell = cells[ri]
		
		if has_unvisited_neighbor(working_cell):
			var cell = get_unvisited_neighbor(working_cell)
			if cell not in cells:
				cells.append(cell)
			
			if cell.location.x == working_cell.location.x:
				if cell.location.y < working_cell.location.y:
					cell.north = true
					working_cell.south = true
				else:
					cell.south = true
					working_cell.north = true
			else:
				if cell.location.x > working_cell.location.x:
					cell.east = true
					working_cell.west = true
				else:
					cell.west = true
					working_cell.east = true
		else:
			cells.remove_at(ri)
