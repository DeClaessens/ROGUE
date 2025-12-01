extends Node

var CardScene: PackedScene = preload("res://Entities/Card/Card.tscn")
var rng = RandomNumberGenerator.new()
const AMOUNT_OF_CARDS = 20

func _ready():
	var viewportRect = get_viewport().get_visible_rect()
	var bottom = viewportRect.position.y + (viewportRect.size.y - 100)
	var center = viewportRect.position.x + 100
	
	for i in AMOUNT_OF_CARDS:
		var card = CardScene.instantiate() as Card
		card.initialize(1, Enums.DIRECTION.values()[rng.randi_range(0, 3)])
		card.position = Vector2(center + 100 * i, bottom)
		add_child(card)
