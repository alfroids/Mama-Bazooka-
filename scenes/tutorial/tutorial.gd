extends Node2D


func _ready() -> void:
	AudioController.play_main_song()
	SignalBus.child_fainted.connect(_on_child_fainted)


func _on_child_fainted() -> void:
	$Tutorial3.visible = true


func _on_easter_egg_timer_timeout() -> void:
	pass # Replace with function body.
