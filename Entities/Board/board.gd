extends Node2D

var TileScene: PackedScene = preload("res://Entities/Tile/Tile.tscn")
var tiles: Array[Tile] = []
var activeTile: Tile = null

@export var rows: int = 3
@export var columns: int = 3
@export var gutter: int = 10

func _ready():
	render_board()
	SignalBus.trait_move_up.connect(_move_up)
	
func move(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		var nextTile = find_next_tile(activeTile, direction)
		if nextTile != activeTile:
			activeTile.set_occupied(false)
			activeTile = null
			nextTile.set_occupied(true)
			activeTile = nextTile

func _move_up(amount):
	for i in amount:
		move(Vector2(0, -1))
	
func find_next_tile(tile, direction: Vector2) -> Tile:
	var newCoordinates = tile.coordinates + direction
	print(activeTile.coordinates, direction)
	var index = tiles.find_custom(func(_tile: Tile):
		return _tile.coordinates == newCoordinates
	)
	
	if index == -1:
		return tile
		
	return tiles.get(index)

func check_coordinates(tile, coordinate):
	return tile.coordinate == coordinate
	
func render_board():
	var columnCounter = 1
	var rowCounter = 1
	
	var center = self.get_viewport_rect().get_center()
	center = center - Vector2(columns * 50 + columns - 1 * gutter, rows * 50 + rows - 1 * gutter)
	
	while(rowCounter <= rows):
		var tile = TileScene.instantiate()
		var yPos = center.y + rowCounter * (50 + gutter)
		var xPos = center.x + columnCounter * (50 + gutter)
		tile.position = Vector2(xPos, yPos)
		tile.set_coordinates(columnCounter, rowCounter)
		if columnCounter % columns == 0:
			rowCounter += 1
			columnCounter = 1
		else:
			columnCounter += 1
			
		add_child(tile)
		tiles.append(tile)
	
	var randomTile = tiles.pick_random()
	randomTile.set_occupied(true)
	activeTile = randomTile
