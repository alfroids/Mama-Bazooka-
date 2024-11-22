class_name Transition
extends Control


@export_file("*.tscn") var next_scene: String


func transition() -> void:
	get_tree().change_scene_to_file(next_scene)
