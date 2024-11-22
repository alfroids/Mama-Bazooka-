extends Control


@export_file("*.tscn") var tutorial: String


func _ready() -> void:
	AudioController.play_titlescreen_song()


func _on_start_pressed():
	get_tree().change_scene_to_file(tutorial)


func _on_credits_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
