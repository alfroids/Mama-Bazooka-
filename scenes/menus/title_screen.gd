extends Control


@export_file("*.tscn") var tutorial: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	AudioController.play_titlescreen_song()
	animation_player.play(&"revealing_info")


func _on_start_pressed():
	get_tree().change_scene_to_file(tutorial)


func _on_credits_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
