class_name Weapon
extends Area2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D as CollisionShape2D


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"hit"):
		collision_shape_2d.disabled = false
	elif event.is_action_released(&"hit"):
		collision_shape_2d.disabled = true


func _on_body_entered(body: Node2D) -> void:
	if body is Child:
		(body as Child).hit()
	elif body is Mother:
		(body as Mother).hit()
