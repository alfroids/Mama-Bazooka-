class_name HUD
extends CanvasLayer


@onready var progress_bar: ProgressBar = $Control/MarginContainer/HBoxContainer/ProgressBar as ProgressBar
@onready var flip_flop_1: TextureRect = $Control/MarginContainer/HBoxContainer/FlipFlop1 as TextureRect
@onready var flip_flop_2: TextureRect = $Control/MarginContainer/HBoxContainer/FlipFlop2 as TextureRect
@onready var flip_flop_3: TextureRect = $Control/MarginContainer/HBoxContainer/FlipFlop3 as TextureRect


func set_time_left(t: float) -> void:
	progress_bar.value = t


func set_hits_left(n: int) -> void:
	if n <= 0:
		flip_flop_1.modulate = Color.BLACK
		flip_flop_2.modulate = Color.BLACK
		flip_flop_3.modulate = Color.BLACK
	elif n == 1:
		flip_flop_1.modulate = Color.WHITE
		flip_flop_2.modulate = Color.BLACK
		flip_flop_3.modulate = Color.BLACK
	elif n == 2:
		flip_flop_1.modulate = Color.WHITE
		flip_flop_2.modulate = Color.WHITE
		flip_flop_3.modulate = Color.BLACK
	else:
		flip_flop_1.modulate = Color.WHITE
		flip_flop_2.modulate = Color.WHITE
		flip_flop_3.modulate = Color.WHITE
