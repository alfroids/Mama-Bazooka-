class_name Door
extends Area2D


const LEVEL_TRANSITION = "res://scenes/level_transition/level_transition.tscn"

@onready var in_focus: bool = false


func _ready() -> void:
	SignalBus.child_fainted.connect(_on_child_fainted)


func interact() -> void:
	#get_tree().change_scene_to_file(LEVEL_TRANSITION)
	get_tree().call_deferred(&"change_scene_to_file", LEVEL_TRANSITION)


func _on_child_fainted() -> void:
	($CollisionShape2D as CollisionShape2D).set_deferred(&"disabled", false)


#func _unhandled_input(event: InputEvent) -> void:
	#if in_focus and event.is_action_pressed(&"interact"):
		#interact()


func _on_body_entered(_body: Node2D) -> void:
	#in_focus = true
	interact()


func _on_body_exited(_body: Node2D) -> void:
	#in_focus = false
	pass
