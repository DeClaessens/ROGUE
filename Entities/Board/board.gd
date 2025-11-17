extends Node2D

var TileScene: PackedScene = preload("res://Entities/Tile/Tile.tscn")
var tiles: Array[Tile] = []
var activeTile: Tile = null

@export var rows: int = 3
@export var columns: int = 3
@export var gutter: int = 10

func _ready():
	render_board()
	
func _process(delta: float) -> void:
	if not tiles or not activeTile:
		return
	var direction = get_direction()
	if direction != Vector2.ZERO:
		var nextTile = find_next_tile(activeTile, direction)
		if nextTile != activeTile:
			activeTile.set_occupied(false)
			activeTile = null
			nextTile.set_occupied(true)
			activeTile = nextTile
		
func get_direction() -> Vector2:
	if Input.is_action_just_pressed("ui_right"):
		return Vector2(1,0)
	if Input.is_action_just_pressed("ui_left"):
		return Vector2(-1,0)
	if Input.is_action_just_pressed("ui_down"):
		return Vector2(0,1)
	if Input.is_action_just_pressed("ui_up"):
		return Vector2(0,-1)
	
	return Vector2.ZERO
	
	
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
	
	while(rowCounter <= rows):
		var tile = TileScene.instantiate()
		# 50 unless rowCounter is higher than 1, in that case add gutter
		var yPos = rowCounter * (50 + gutter)
		# 50 unless columnCounter is higher than 1, in that case add gutter
		var xPos = columnCounter * (50 + gutter)
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
