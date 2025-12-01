extends Area2D
class_name Card

var TraitMoveComponentScene: PackedScene = preload("res://Components/Traits/TraitMoveComponent/TraitMoveComponent.tscn")

func _ready() -> void:
	print('ready')

func initialize(amount: int, direction: Enums.DIRECTION):
	var traitMoveComponent = TraitMoveComponentScene.instantiate()
	traitMoveComponent.initialize(amount, direction)
	self.scale = Vector2(2,2)
	_set_card_image(direction)
	add_child(traitMoveComponent)

func play():
	print('i have been played')

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.double_click):
			SignalBus.card_played.emit(self)

func _set_card_image(direction: Enums.DIRECTION) -> void:
	var sprite: Sprite2D = $Sprite2D
	var dir = Enums.DIRECTION.keys()[direction].to_upper()
	print(dir)
	sprite.texture = load("res://Assets/CARD_" + dir + ".png")
