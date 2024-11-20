extends Interactable


func interact() -> void:
	print("level complete.")
	print("exiting level...")


func _on_child_fainted() -> void:
	($CollisionShape2D as CollisionShape2D).disabled = false
