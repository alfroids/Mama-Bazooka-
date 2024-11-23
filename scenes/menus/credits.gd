extends Control


const TITLE_SCREEN: String = "res://scenes/menus/title_screen.tscn"


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(TITLE_SCREEN)
