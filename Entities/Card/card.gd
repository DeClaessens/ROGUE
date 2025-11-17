extends Area2D
class_name Card


func _ready() -> void:
	print('ready')

func play():
	print('i have been played')

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.double_click):
			SignalBus.card_played.emit(self)
