extends Node
class_name TraitUpComponent

@onready var consumer: Card = get_parent()

@export var amount: int = 1

func _ready():
	# Connect automatically if parent is Card
	if consumer is Card:
		SignalBus.card_played.connect(_on_played)
	else:
		push_warning("TraitUpComponent: Parent is not a Card. No collision click detection.")

func _on_played(card: Card):
	if (consumer == card):
		SignalBus.trait_move_up.emit(amount)
