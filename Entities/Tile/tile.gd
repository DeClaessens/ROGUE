extends Area2D
class_name Tile

var coordinates: Vector2 = Vector2.ZERO
var occupied: bool = false
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	queue_redraw()

func set_coordinates(x: int, y: int) -> void:
	coordinates = Vector2(x, y)
	
func set_occupied(value: bool) -> void:
	self.occupied = value
	queue_redraw()
	
func _draw():
		var shape = collision_shape.get_shape()
		if shape is RectangleShape2D:
			var rect = shape.get_rect()
			var color = Color.RED if occupied else Color.PURPLE
			draw_rect(rect, color, false)
