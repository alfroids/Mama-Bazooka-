class_name Door
extends Interactable


const LEVEL_TRANSITION = "res://scenes/level_transition/level_transition.tscn"

func interact() -> void:
	get_tree().change_scene_to_file(LEVEL_TRANSITION)


func _on_child_fainted() -> void:
	($CollisionShape2D as CollisionShape2D).set_deferred(&"disabled", false)
