extends Node
class_name TraitMoveComponent

# This component adds a Move trait to the Card.
# The amount of movement is configurable, as is the direction.

@onready var consumer: Card = get_parent()

@export var amount: int
@export var direction: Enums.DIRECTION 

func _ready():
	# Connect automatically if parent is Card
	if consumer is Card:
		SignalBus.card_played.connect(_on_played)
	else:
		push_warning("TraitMoveComponent: Parent is not a Card. No collision click detection.")

func initialize(_amount: int, _direction: Enums.DIRECTION):
	self.amount = _amount
	self.direction = _direction

func _on_played(card: Card):
	if (consumer == card):
		SignalBus.trait_move.emit(amount, direction)
