extends Transition


func _ready() -> void:
	Manager.horde_size += 1


func _on_transition_timer_timeout() -> void:
	transition()
