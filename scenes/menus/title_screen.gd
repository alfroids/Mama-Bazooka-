extends Control

const TUTORIAL: String = "res://scenes/tutorial/tutorial.tscn"
const CREDITS: String = "res://scenes/menus/credits.tscn"

@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	Level.horde_size = 0
	AudioController.play_titlescreen_song()
	animation_player.play(&"revealing_info")


func _on_start_pressed():
	get_tree().change_scene_to_file(TUTORIAL)


func _on_credits_pressed():
	get_tree().change_scene_to_file(CREDITS)


func _on_quit_pressed():
	get_tree().quit()
