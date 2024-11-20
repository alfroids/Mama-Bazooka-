extends Node2D


func _ready() -> void:
	($Child as Child).mother = ($Mother as Mother)
	($Child as Child).fainted.connect(($Mother as Mother)._on_child_fainted)
