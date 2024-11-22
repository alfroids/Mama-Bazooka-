extends Control


const TUTORIAL: String = "res://scenes/tutorial/tutorial.tscn"


func _ready() -> void:
	AudioController.play_titlescreen_song()


func _on_start_pressed():
	get_tree().change_scene_to_file(TUTORIAL)


func _on_credits_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
