extends Control


const TITLE_SCREEN: String = "res://scenes/menus/title_screen.tscn"


func enable() -> void:
	visible = true
	get_tree().paused = true


func _on_title_screen_button_pressed() -> void:
	get_tree().change_scene_to_file(TITLE_SCREEN)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
