extends Control



func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/cutscenes/intro_scene.tscn")


func _on_credits_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
