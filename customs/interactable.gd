class_name Interactable
extends Area2D


@onready var in_focus: bool = false


func interact() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if in_focus and event.is_action_pressed(&"interact"):
		interact()


func _on_body_entered(_body: Node2D) -> void:
	in_focus = true


func _on_body_exited(_body: Node2D) -> void:
	in_focus = false
