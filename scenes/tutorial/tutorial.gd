extends Node2D


func _ready() -> void:
	AudioController.play_main_song()


func _on_easter_egg_timer_timeout() -> void:
	pass # Replace with function body.
