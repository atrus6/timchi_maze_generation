# Timchi Maze Generation
This plugin adds a Maze3D node to your toolset. Utilizing a GridMap and MeshLibrary, this will create a [width]x[height] size maze, as well as an optional NavigationMesh3D.

This is also a tool script, which allows realtime viewing and editing of the resulting maze. 
Mazes are generated off a seed, and a given width, height, linearity, and seed will be identical.

## Usage
1. Install the plugin
2. Add node to tree.

## Tuning
Lots of things to adjust and tune!
The below describes what each parameter does by default.

### Maze Width
The width of the maze, along the positive X axis.

### Maze Height
The height of the maze, along the positive Z axis.

### Linearity
How much the maze tends to form straight hallways. 0 for lots of straightaway, 1 for few.
It's a bit backwards in how it's named.

### Seed
The random number start. A given seed, width, height, and linearity will give the same maze.

### Generate NavMesh
If checked, generates a NavigationMesh3D for the given maze, to allow for your characters to travel through the maze easily.
Off by default, as it's a bit slower than the actual maze generation.

### Cell Items
The *Dead End*, *Hallway*, *Corner*, *Junction*, and *All Way* integers all help map your MeshLibrary to maze specific tiles.
Not all MeshLibraries have everything in the same order!

### Mesh Library
This is what the Maze3D node will pull for its models in building the maze. There should be at least 1 mesh for each maze cell type.

### Mesh Adjust
This is a Basis for rotating the _entire_ mesh library. Some MeshLibraries imported sideways/wonky and this provides an easy way to fix.

### Rotation Adjustment
Rotates all _individual_ tiles by given amount in degrees. Locked to 90° intervals.

## Roadmap
* 2D Tilemap Mazes
* Multi-level mazes
* Easier editing of generated mazes.

## Credits
Example Textures for maze were provided by [Jestan](https://opengameart.org/content/pixel-texture-pack)
